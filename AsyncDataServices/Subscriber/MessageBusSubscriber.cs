using System;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration; // Ensure you have this namespace imported
using Microsoft.Extensions.DependencyInjection; // Ensure you have this namespace imported
using Microsoft.Extensions.Hosting;
using OrderMicroservice.MessageBusEvents;
using OrderMicroservice.Data.Interfaces;
using OrderMicroservice.Models;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using RedLockNet;
using RedLockNet.SERedis;
using StackExchange.Redis;
using RedLockNet.SERedis.Configuration;

namespace OrderMicroservice.AsyncDataServices.Subscriber
{
    public class MessageBusSubscriber : BackgroundService
    {
        private IConnection _connection;
        private IModel _channel;
        private string _queueName;
        private readonly IServiceScopeFactory _scopeFactory;
        private IOrderRepo orderRepository => _scopeFactory.CreateScope().ServiceProvider.GetRequiredService<IOrderRepo>();
        private readonly RedLockFactory _redLockFactory;
        private readonly IConfiguration _configuration;

        public MessageBusSubscriber(IConfiguration configuration, IServiceScopeFactory scopeFactory)
        {
            try
            {
                _configuration = configuration;
                _scopeFactory = scopeFactory;
                var redisConnectionString = "localhost:6379,abortConnect=false";
                try
                {
                    var redisMultiplexer = ConnectionMultiplexer.Connect(redisConnectionString);
                    _redLockFactory = RedLockFactory.Create(new[] { new RedLockMultiplexer(redisMultiplexer) });
                }
                catch (Exception ex)
                {
                    // Log or handle the exception appropriately
                    Console.WriteLine($"Error connecting to Redis: {ex.Message}");
                }
                InitializeRabbitMQ();
            }
            catch (Exception ex) 
            {
                // Log or handle the exception appropriately
                Console.WriteLine($"Error connecting to Redis: {ex.Message}");
            }
        }

        private void InitializeRabbitMQ()
        {
            var factory = new ConnectionFactory()
            {
                HostName = _configuration["RabbitMQHost"],
                Port = int.Parse(_configuration["RabbitMQPort"])
            };

            _connection = factory.CreateConnection();
            _channel = _connection.CreateModel();
            _channel.ExchangeDeclare(exchange: "topic-exchange", type: ExchangeType.Topic);
            _queueName = _channel.QueueDeclare().QueueName;
            _channel.QueueBind(queue: _queueName, exchange: "topic-exchange", routingKey: "user.*");

            Console.WriteLine("--> Listening on the Message Bus...");

            _connection.ConnectionShutdown += RabbitMQ_ConnectionShutdown;
        }

        protected override Task ExecuteAsync(CancellationToken stoppingToken)
        {
            stoppingToken.ThrowIfCancellationRequested();

            var consumer = new EventingBasicConsumer(_channel);

            consumer.Received += async (ModuleHandle, ea) =>
            {
                try
                {
                    // Get message body
                    byte[] body = ea.Body.ToArray();
                    string serializedMessage = Encoding.UTF8.GetString(body);

                    // Deserialize message
                    if (ea.RoutingKey == "user.registered")
                    {
                        var userRegisteredEvent = JsonSerializer.Deserialize<UserRegisteredEvent>(serializedMessage);

                        using (var redLock = await _redLockFactory.CreateLockAsync("user.registered", TimeSpan.FromSeconds(30)))
                        {
                            if (redLock.IsAcquired)
                            {
                                // Process the message
                                await ProcessUserRegisteredEvent(userRegisteredEvent, orderRepository);
                                _channel.BasicAck(ea.DeliveryTag, false);
                            }
                            else
                            {
                                Console.WriteLine("--> Could not acquire lock. Skipping duplicate processing.");
                                _channel.BasicNack(ea.DeliveryTag, false, false);
                            }
                        }
                    }
                    else
                    {
                        Console.WriteLine($"Received a message with unexpected routing key: {ea.RoutingKey}");
                        _channel.BasicNack(ea.DeliveryTag, false, false);
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception with additional details
                    Console.WriteLine($"Error in Received event handler: {ex.Message}");
                }
            };

            // Start consuming messages
            _channel.BasicConsume(queue: _queueName, autoAck: false, consumer: consumer);

            // Return a completed task
            return Task.CompletedTask;
        }

        private async Task ProcessUserRegisteredEvent(UserRegisteredEvent userRegisteredEvent, IOrderRepo orderRepository)
        {
            Console.WriteLine("--> Processing UserRegisteredEvent");
            Console.WriteLine($"--> UserId: {userRegisteredEvent.UserId}");

            var order = new Models.Order
            {
                CustomerId = userRegisteredEvent.UserId,
                Created = DateTime.UtcNow
            };

            orderRepository.CreateOrder(order);

            Console.WriteLine("--> Empty row created in the Order table.");
        }

        private void RabbitMQ_ConnectionShutdown(object sender, ShutdownEventArgs e)
        {
            Console.WriteLine("--> RabbitMQ Connection Shutdown");
        }
    }
}

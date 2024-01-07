using System;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using OrderMicroservice.MessageBusEvents;
using OrderMicroservice.Data.Interfaces;
using OrderMicroservice.Data.Repositories;
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
        private readonly RedLockFactory _redLockFactory;
        private readonly IConfiguration _configuration;

        public MessageBusSubscriber(IConfiguration configuration, IServiceScopeFactory scopeFactory)
        {
            try
            {
                _configuration = configuration;
                _scopeFactory = scopeFactory;
                var redisConnectionString = "localhost:6379";
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
            try
            {
                stoppingToken.ThrowIfCancellationRequested();

                if (_channel == null || _channel.IsClosed)
                {
                    Console.WriteLine("Error: RabbitMQ channel is null or closed.");
                    return Task.CompletedTask;
                }

                var consumer = new EventingBasicConsumer(_channel);

                consumer.Received += async (ModuleHandle, ea) =>
                {
                    try
                    {
                        // ... (omitted for brevity)

                        if (_channel != null && _channel.IsOpen)  // Check if the channel is open
                        {
                            _channel.BasicConsume(queue: _queueName, autoAck: false, consumer: consumer);
                        }
                        else
                        {
                            Console.WriteLine("Error: RabbitMQ channel is null or closed.");
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log the exception with additional details
                        Console.WriteLine($"Error in Received event handler: {ex.Message}");
                    }
                };

                _channel.BasicConsume(queue: _queueName, autoAck: false, consumer: consumer);
            }
            catch (Exception ex)
            {
                // Log the exception with additional details
                Console.WriteLine($"Error in ExecuteAsync: {ex.Message}");
            }

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

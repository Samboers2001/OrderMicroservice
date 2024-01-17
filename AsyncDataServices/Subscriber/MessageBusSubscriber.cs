using System;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using OrderMicroservice.MessageBusEvents;
using OrderMicroservice.Data.Interfaces;
using OrderMicroservice.Models;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using StackExchange.Redis;

namespace OrderMicroservice.AsyncDataServices.Subscriber
{
    public class MessageBusSubscriber : BackgroundService
    {
        private IConnection _connection;
        private IModel _channel;
        private string _queueName;
        private readonly IServiceScopeFactory _scopeFactory;
        private IOrderRepo OrderRepository => _scopeFactory.CreateScope().ServiceProvider.GetRequiredService<IOrderRepo>();
        private IProductRepo ProductRepository => _scopeFactory.CreateScope().ServiceProvider.GetRequiredService<IProductRepo>();
        private readonly IConfiguration _configuration;

        public MessageBusSubscriber(IConfiguration configuration, IServiceScopeFactory scopeFactory)
        {
            try
            {
                _configuration = configuration;
                _scopeFactory = scopeFactory;
                var redisConnectionString = "localhost:6379,abortConnect=false";
                InitializeRabbitMQ();
            }
            catch (Exception ex)
            {
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

            // Declare the exchange
            _channel.ExchangeDeclare(exchange: "topic-exchange", type: ExchangeType.Topic);

            // Declare the queue
            _queueName = "SharedQueue";
            _channel.QueueDeclare(queue: _queueName, durable: true, exclusive: false, autoDelete: false, arguments: null);

            // Bind the queue to the exchange with wildcard routing key pattern
            _channel.QueueBind(queue: _queueName, exchange: "topic-exchange", routingKey: "user.*");
            _channel.QueueBind(queue: _queueName, exchange: "topic-exchange", routingKey: "product.*");

            Console.WriteLine("--> Listening on the Message Bus...");

            _connection.ConnectionShutdown += RabbitMQ_ConnectionShutdown;
        }


        protected override Task ExecuteAsync(CancellationToken stoppingToken)
        {
            stoppingToken.ThrowIfCancellationRequested();

            // Create a new instance of AcknowledgmentHandler
            var acknowledgmentHandler = new AcknowledgmentHandler(_configuration, _scopeFactory);
            acknowledgmentHandler.Start();

            var consumer = new EventingBasicConsumer(_channel);

            consumer.Received += async (ModuleHandle, ea) =>
            {
                try
                {
                    byte[] body = ea.Body.ToArray();
                    string serializedMessage = Encoding.UTF8.GetString(body);

                    if (ea.RoutingKey == "user.registered")
                    {
                        var userRegisteredEvent = JsonSerializer.Deserialize<UserRegisteredEvent>(serializedMessage);

                        // Process the message
                        await ProcessUserRegisteredEvent(userRegisteredEvent, OrderRepository);

                        // Send acknowledgment
                        SendAcknowledgment(userRegisteredEvent.UserId);

                        // Acknowledge the original message
                        _channel.BasicAck(ea.DeliveryTag, false);
                    }
                    else if (ea.RoutingKey == "product.created")
                    {
                        var productCreatedEvent = JsonSerializer.Deserialize<ProductCreatedEvent>(serializedMessage);

                        // Process the message
                        await ProcessProductCreated(productCreatedEvent, ProductRepository);

                        // Send acknowledgment
                        SendAcknowledgment(productCreatedEvent.ExternalProductId.ToString());

                        // Acknowledge the original message
                        _channel.BasicAck(ea.DeliveryTag, false);
                    } else
                    {
                        Console.WriteLine($"Received a message with unexpected routing key: {ea.RoutingKey}");
                        _channel.BasicNack(ea.DeliveryTag, false, false);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error in Received event handler: {ex.Message}");
                }
            };

            // Start consuming messages
            _channel.BasicConsume(queue: _queueName, autoAck: false, consumer: consumer);

            return Task.CompletedTask;
        }

        private async Task ProcessUserRegisteredEvent(UserRegisteredEvent userRegisteredEvent, IOrderRepo orderRepository)
        {
            Console.WriteLine("--> Processing UserRegisteredEvent");
            Console.WriteLine($"--> UserId: {userRegisteredEvent.UserId}");

            // Check if an order already exists for this user
            var existingOrder = orderRepository.GetOrderByCustomerId(userRegisteredEvent.UserId);
            if (existingOrder != null)
            {
                Console.WriteLine($"--> Order already exists for UserId: {userRegisteredEvent.UserId}");
                return;
            }

            var order = new Models.Order
            {
                CustomerId = userRegisteredEvent.UserId,
                Created = DateTime.UtcNow
            };

            orderRepository.CreateOrder(order);
            // Ensure to save the changes to the database
            await orderRepository.SaveChangesAsync();

            Console.WriteLine("--> Order created for UserId: {userRegisteredEvent.UserId}");
        }

        private async Task ProcessProductCreated(ProductCreatedEvent productCreatedEvent, IProductRepo productRepository)
        {
            Console.WriteLine("--> Processing ProductCreatedEvent");
            Console.WriteLine($"--> ProductId: {productCreatedEvent.ExternalProductId}");

            // Check if an order already exists for this user
            var existingOrder = productRepository.GetProductById(productCreatedEvent.ExternalProductId);
            if (existingOrder != null)
            {
                Console.WriteLine($"--> Product already exists with Id: {productCreatedEvent.ExternalProductId}");
                return;
            }

            var product = new Product
            {
                ExternalProductId = productCreatedEvent.ExternalProductId,
                Created = DateTime.UtcNow
            };

            productRepository.CreateProduct(product);
            // Ensure to save the changes to the database
            await productRepository.SaveChangesAsync();

            Console.WriteLine($"--> Order created for UserId: {productCreatedEvent.ExternalProductId}");
        }


        private void SendAcknowledgment(string userId)
        {
            using (var acknowledgmentChannel = _connection.CreateModel())
            {
                acknowledgmentChannel.ExchangeDeclare(exchange: "ack-exchange", type: ExchangeType.Fanout);

                var acknowledgmentMessage = Encoding.UTF8.GetBytes($"Acknowledgment for {userId}");
                acknowledgmentChannel.BasicPublish(exchange: "ack-exchange", routingKey: "", basicProperties: null, body: acknowledgmentMessage);
            }
        }

        private void RabbitMQ_ConnectionShutdown(object sender, ShutdownEventArgs e)
        {
            Console.WriteLine("--> RabbitMQ Connection Shutdown");
        }
    }

    public class AcknowledgmentHandler
    {
        private IConnection _connection;
        private IModel _channel;
        private readonly IServiceScopeFactory _scopeFactory;
        private readonly IConfiguration _configuration;

        public AcknowledgmentHandler(IConfiguration configuration, IServiceScopeFactory scopeFactory)
        {
            _configuration = configuration;
            _scopeFactory = scopeFactory;
        }

        public void Start()
        {
            var factory = new ConnectionFactory()
            {
                HostName = _configuration["RabbitMQHost"],
                Port = int.Parse(_configuration["RabbitMQPort"])
            };

            _connection = factory.CreateConnection();
            _channel = _connection.CreateModel();
            _channel.ExchangeDeclare(exchange: "ack-exchange", type: ExchangeType.Fanout);

            var acknowledgmentQueueName = _channel.QueueDeclare().QueueName;
            _channel.QueueBind(queue: acknowledgmentQueueName, exchange: "ack-exchange", routingKey: "");

            var consumer = new EventingBasicConsumer(_channel);

            consumer.Received += (ModuleHandle, ea) =>
            {
                Console.WriteLine($"Received acknowledgment: {Encoding.UTF8.GetString(ea.Body.ToArray())}");
            };

            _channel.BasicConsume(queue: acknowledgmentQueueName, autoAck: true, consumer: consumer);
        }
    }
}

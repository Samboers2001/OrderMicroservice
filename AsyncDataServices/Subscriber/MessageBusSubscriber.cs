using System.Text;
using System.Text.Json;
using OrderMicroservice.MessageBusEvents;
using OrderMicroservice.Data.Interfaces;
using OrderMicroservice.Data.Repositories;
using OrderMicroservice.Models;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;

namespace OrderMicroservice.AsyncDataServices.Subscriber
{
    public class MessageBusSubscriber : BackgroundService
    {
        private readonly IConfiguration _configuration;
        private IConnection _connection;
        private IModel _channel;
        private string _queueName;
        private readonly IServiceScopeFactory _scopeFactory;

        public MessageBusSubscriber(IConfiguration configuration, IServiceScopeFactory scopeFactory)
        {
            _configuration = configuration;
            _scopeFactory = scopeFactory;
            InitializeRabbitMQ();
        }

        private void InitializeRabbitMQ()
        {
            ConnectionFactory factory = new ConnectionFactory()
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

            EventingBasicConsumer consumer = new EventingBasicConsumer(_channel);

            consumer.Received += async (ModuleHandle, ea) =>
            {
                using (var scope = _scopeFactory.CreateScope())
                {
                    IOrderRepo scopedOrderRepo = scope.ServiceProvider.GetRequiredService<IOrderRepo>();
                    byte[] body = ea.Body.ToArray();
                    string serializedMessage = Encoding.UTF8.GetString(body);
                    if (ea.RoutingKey == "user.registered")
                    {
                        var userRegisteredEvent = JsonSerializer.Deserialize<UserRegisteredEvent>(serializedMessage);
                        await ProcessUserRegisteredEvent(userRegisteredEvent, scopedOrderRepo);
                        _channel.BasicAck(ea.DeliveryTag, false);
                    }
                    else
                    {
                        Console.WriteLine($"Received a message with unexpected routing key: {ea.RoutingKey}");
                        _channel.BasicNack(ea.DeliveryTag, false, false);
                    }
                }
            };

            _channel.BasicConsume(queue: _queueName, autoAck: false, consumer: consumer);
            return Task.CompletedTask;
        }

        private async Task ProcessUserRegisteredEvent(UserRegisteredEvent userRegisteredEvent, IOrderRepo orderRepository)
        {
            Console.WriteLine("--> Processing UserRegisteredEvent");
            Console.WriteLine($"--> UserId: {userRegisteredEvent.UserId}");

            var order = new Order
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

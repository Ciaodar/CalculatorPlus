using System;
using System.Text;
using RabbitMQ.Client;

namespace calculatorApi.Services
{
    public class RabbitMQService
    {
        private readonly IConnection _connection;
        private readonly IModel _channel;
        private const string QueueName = "mesaj-kuyruk";

        public RabbitMQService(string rabbitMQConnectionString)
        {
            var factory = new ConnectionFactory
            {
                Uri = new Uri("amqps://ejejtxro:zt5zcNLY1EsDdMdKQ_KsIh9Q5AT3R7Fu@jackal.rmq.cloudamqp.com/ejejtxro")
            };
            _connection = factory.CreateConnection();
            _channel = _connection.CreateModel();
            _channel.QueueDeclare(QueueName, true, false, false);
        }

        public void SendMessage(string message)
        {
            var body = Encoding.UTF8.GetBytes(message);
            _channel.BasicPublish(string.Empty, QueueName, null, body);
        }

        public void CloseConnection()
        {
            _channel.Close();
            _connection.Close();
        }
    }
}

using calculatorApi.Models;
using RabbitMQ.Client;
namespace calculatorApi.Services.RabbitMQProducer.Helper
{
    public class ProducerMQ : ISendMessage
    {
        public void SendMessage(string message)
        {
            var connection = RabbitHelper.GetConnection;
            var channel = connection.CreateModel();
            channel.QueueDeclare("CalculationQueue", false, false, false, null);
            var body = StringExtensions.GetBytes(message);
            channel.BasicPublish("", "CalculationQueue", null, body);
        }
    }
}


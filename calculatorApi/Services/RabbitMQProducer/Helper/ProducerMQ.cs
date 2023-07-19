using calculatorApi.Models;
using RabbitMQ.Client;
namespace calculatorApi.Services.RabbitMQProducer.Helper
{
    public class ProducerMQ : ISendMessage
    {
        //var rabbitMQService = new RabbitMQService("amqps://ejejtxro:zt5zcNLY1EsDdMdKQ_KsIh9Q5AT3R7Fu@jackal.rmq.cloudamqp.com/ejejtxro");
        //var message = JsonConvert.SerializeObject(calculation);
        //rabbitMQService.SendMessage(message);

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


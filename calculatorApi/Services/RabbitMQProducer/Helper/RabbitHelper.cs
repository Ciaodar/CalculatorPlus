using System;
using System.Text;
using RabbitMQ.Client;
namespace calculatorApi.Services.RabbitMQProducer.Helper
{
    public class RabbitHelper
     {
         static Lazy<IConnection> _connection = new Lazy<IConnection>(CreateConnection);
         public static IConnection GetConnection => _connection.Value;
         static IConnection CreateConnection()
         {
            var factory = new ConnectionFactory();
            factory.Uri = new Uri("amqps://ejejtxro:zt5zcNLY1EsDdMdKQ_KsIh9Q5AT3R7Fu@jackal.rmq.cloudamqp.com/ejejtxro");
            var connection = factory.CreateConnection();
            return connection;
         }
     }
}


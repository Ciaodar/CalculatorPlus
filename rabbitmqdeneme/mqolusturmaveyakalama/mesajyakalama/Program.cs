using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Text;

namespace mesajyakalama

{
    internal class Program
    {
        static void Main(string[] args)
        {
            var factory= new ConnectionFactory();
            factory.Uri=new Uri("amqps://ejejtxro:zt5zcNLY1EsDdMdKQ_KsIh9Q5AT3R7Fu@jackal.rmq.cloudamqp.com/ejejtxro");

            using var connection = factory.CreateConnection();  
            var channel =connection.CreateModel();

            channel.QueueDeclare("mesaj-kuyruk", true, false, false);

            var consumer =new EventingBasicConsumer(channel);
            channel.BasicConsume("mesaj-kuyruk", true, consumer);
            consumer.Received += Consumer_Received;
                

        }

        private static void Consumer_Received(object? sender, BasicDeliverEventArgs e)
        {
            Console.WriteLine(Encoding.UTF8.GetString(e.Body.ToArray()));
        }
    }
}
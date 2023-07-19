using RabbitMQ.Client;
using System;
using System.Text;

namespace mqolusturmaveyakalama

{
    internal class Program
    {
        static void Main(string[] args)
        {
            var factory = new ConnectionFactory();
            factory.Uri = new Uri("amqps://ejejtxro:zt5zcNLY1EsDdMdKQ_KsIh9Q5AT3R7Fu@jackal.rmq.cloudamqp.com/ejejtxro");
            using var connection = factory.CreateConnection();
            var channel = connection.CreateModel();
            channel.QueueDeclare("mesaj-kuyruk", true, false, false);
            var mesaj = "deneme mesaj";
            var body = Encoding.UTF8.GetBytes(mesaj);
            channel.BasicPublish(string.Empty, "mesaj-kuyruk", null, body);
            Console.WriteLine("Hello, World!");
            Console.ReadLine();
        }
    
        
    }
}
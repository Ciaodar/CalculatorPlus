using System;
namespace calculatorApi.Services.RabbitMQProducer.Helper
{
    public interface ISendMessage
    {
        void SendMessage(string message);
    }
}


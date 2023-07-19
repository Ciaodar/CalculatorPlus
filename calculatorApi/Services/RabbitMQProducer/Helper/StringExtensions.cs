using System;
using System.Text;

namespace calculatorApi.Services.RabbitMQProducer.Helper
{
    public static class StringExtensions
    {
        public static byte[] GetBytes(this string value) {
            return Encoding.ASCII.GetBytes(value);
        }

        public static string GetString(this byte[] value) {
            return Encoding.UTF8.GetString(value);
        }
    }
}


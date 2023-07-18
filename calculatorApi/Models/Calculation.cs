namespace calculatorApi.Models
{
    public class Calculation
    {
        public int input1 { get; set; }
        public int input2 { get; set; }
        public int result { get; set; }
        public string signOperation { get; set; }
    }
    var rabbitMQService = new RabbitMQService("amqps://ejejtxro:zt5zcNLY1EsDdMdKQ_KsIh9Q5AT3R7Fu@jackal.rmq.cloudamqp.com/ejejtxro");
    var message = JsonConvert.SerializeObject(calculation);
    rabbitMQService.SendMessage(message);
}


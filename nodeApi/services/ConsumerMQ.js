const amqp = require('amqplib');
const MakeCalculationAndSend = require('./MakeCalculationAndSend');

async function consumeMessages() {
  try {
    const connection = await amqp.connect('amqps://ejejtxro:zt5zcNLY1EsDdMdKQ_KsIh9Q5AT3R7Fu@jackal.rmq.cloudamqp.com/ejejtxro'); // RabbitMQ bağlantı adresini 
    const channel = await connection.createChannel();

    const queue = 'CalculationQueue'; // Tüketilecek kuyruk adı
    await channel.assertQueue(queue, { durable: false });

    console.log('Consumer is being started. Waiting for messages...');

    channel.consume(queue, (msg) => {
      const message = msg.content.toString();
      console.log('Alınan mesaj:', message);
      channel.ack(msg); // Mesajı işlendi olarak işaretleme
      MakeCalculationAndSend(message);//Mesaj işlenip cevap hazırlanıyor
    });
  } catch (error) {
    console.error('Hata:', error);
  }
}

module.exports = consumeMessages;

const kafka = require('kafka-node');
const Consumer = kafka.Consumer;
//const kafkaHost = 'kafka-svc:9093';
const kafkaHost = process.env.kafkaHost || 'localhost:9092';
const client = new kafka.KafkaClient({kafkaHost: kafkaHost});
console.log('KafkaHost=' + kafkaHost);

const consumer = new Consumer(client,
	[
		{ topic: 'test'}
	],
	{
		autoCommit: false
	}
);

consumer.on('error', function (message) {
	console.log(message);
});

consumer.on('message', function (message) {
    console.log(message);
});
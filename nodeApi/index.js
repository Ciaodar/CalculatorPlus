const express=require('express');
const http = require('http');
const webSocket = require('ws');
require('./db/dbCon');
const consumer = require('./services/ConsumerMQ');

const dbrouter = require('./router/dbrouter');
//const redisrouter = require('./router/redisRouter');
const Socket = require('./services/Socket');
const redisRout = require('./router/redisrouter');
const app = express();

const cacheRedis = require('./services/cacheredis');


app.use(express.json())
app.use(express.urlencoded({ extended: true }))

const server= http.createServer(app);
server.listen(3000,()=>console.log('Server is running succesfully...'));
const wss = new webSocket.Server({server:server});

app.get('/',(req,res)=> {
    res.send('Bu API Bimser Yaz Staji için geliştirilmiştir.');
} );

app.use('/api',dbrouter);

app.use('/api',redisRout);


consumer();
cacheRedis.redisClient;
Socket.SocketServer(wss);
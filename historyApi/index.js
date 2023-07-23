const express=require('express');
const http = require('http');
const webSocket = require('ws');
require('./db/dbCon');
const consumer = require('./services/ConsumerMQ');
const mongoose= require('mongoose');
const dbrouter = require('./router/dbrouter');
const cacherouter = require('./router/redisrouter');
const Socket = require('./services/Socket');

const app = express();

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

const server= http.createServer(app);
server.listen(3000,()=>console.log('Server is running succesfully...'));
const wss = new webSocket.Server({server:server});

app.get('/',(req,res)=> {
    res.send('Bu API Bimser Yaz Staji için geliştirilmiştir.');
} );

app.get('/history',dbrouter);
app.get('/cache',cacherouter);

consumer();
Socket.SocketServer(wss);

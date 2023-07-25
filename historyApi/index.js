const express=require('express');
const http = require('http');
const webSocket = require('ws');
require('./db/dbCon');
const consumer = require('./services/ConsumerMQ');

const dbrouter = require('./router/dbrouter');
//const redisrouter = require('./router/redisRouter');
const Socket = require('./services/Socket');

const app = express();
console.log("3");
const redisRout = require('./router/redisrouter');




app.use(express.json())
app.use(express.urlencoded({ extended: true }))

const server= http.createServer(app);
server.listen(3000,()=>console.log('Server is running succesfully...'));
const wss = new webSocket.Server({server:server});

app.get('/',(req,res)=> {
    res.send('Bu API Bimser Yaz Staji için geliştirilmiştir.');
} );

app.use('/api',dbrouter);
console.log("1");
app.use('/api',redisRout);          // HATA BURADAN GELİYOR , ROUTER'DA PROBLEM VAR
console.log("2");

consumer();
Socket.SocketServer(wss);

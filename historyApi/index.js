const express=require('express');
const connectDB=require('./db/dbCon');
const consumer = require('./services/ConsumerMQ');

const mongoose= require('mongoose');
const dbrouter = require('./router/dbrouter');
const cacherouter = require('./router/redisrouter')

connectDB();



const server= express();
server.use(express.json())
server.use(express.urlencoded({ extended: true }))


server.get('/',(req,res)=> {
    res.send('Bu API Bimser Yaz Staji için geliştirilmiştir.');
} );

server.get('/history',dbrouter);

server.get('/cache',cacherouter);

mongoose.connection.once('open', ()=>{
    console.log('Connected to MongoDB')
    server.listen(5000, () =>{
        console.log('Server running on: http://localhost:5000')
    });
});

consumer();

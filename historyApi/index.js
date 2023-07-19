const express=require('express');
const connectDB=require('./dbcon');
const mongoose= require('mongoose');
const Input=require('./models/inputschema');
const dbrouter = require('./router/dbrouter');
const bodyParser = require('body-parser');
const cacherouter = require('./router/redisrouter')

connectDB();



const server= express();
server.use(bodyParser.json())
server.use(bodyParser.urlencoded({ extended: true }))


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

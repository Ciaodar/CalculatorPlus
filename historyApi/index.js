const express=require('express');
const connectDB=require('./dbcon');
const mongoose= require('mongoose');
const Input=require('./models/inputschema');
const router = require('./router/dbrouter');

connectDB();

const server= express();

server.get('/',(req,res)=> {
    res.send('Bu API Bimser Yaz Staji için geliştirilmiştir.');
} );

router()

mongoose.connection.once('open', ()=>{
    console.log('Connected to MongoDB')
    server.listen(5000, () =>{
        console.log('Server running on: http://localhost:5000')
    });
})

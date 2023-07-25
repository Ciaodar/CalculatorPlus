// const express = require('express');
// const router = express.Router();

// const redist=require('../services/cacheredis');

// router.get('/cache', async(req,res) => {
//     const id = req.query.id;
//     const response = await redist(id);
//     res.json(response);
// });

const express = require('express');
const redisClient = express.Router();

module.exports = (router) => {
    router.get('../index',async(req,res)=>{
        res.json({
            message: 'Redis router calisti.'
        })
    })
}
module.exports=redisClient;





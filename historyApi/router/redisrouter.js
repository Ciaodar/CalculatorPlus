
const express = require('express');
const router = express.Router();
const redist = require('../services/cacheredis');

router.get('/cache', async(req,res) => {
    const id = req.query.id;
    const response = await redist(id);
    res.json(response);
});

module.exports = router;


// const express = require('express');
// const rediss = express.Router();
// // const redisClient = require("../services/cacheredis");

// module.exports = (router) => {
//     router.get('../index',async(req,res)=>{
//         res.json({
//             message: 'Redis router calisti.'
//         })
//         console.log("router calisti");
//     })
// }



// module.exports= rediss;







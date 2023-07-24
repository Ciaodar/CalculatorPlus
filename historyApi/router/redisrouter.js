const redist=require('../services/cacheredis');
const express=require('express');
const router=express.Router();

router.get('/',async(req,res) => {
    console.log('Geldi')
    const response = await redist(req.query.id);
    res.json(response)
});

module.exports=router;

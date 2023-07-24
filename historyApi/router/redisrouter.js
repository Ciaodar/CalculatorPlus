const redist=require('../services/cacheredis');
const express=require('express');
const router=express.Router();

router.get('/:id',async(req,res) => {
    console.log('Geldi')
    const response = await redist(req.params.id);
    res.json(response)
});

module.exports=router;

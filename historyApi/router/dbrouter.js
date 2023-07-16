const express=require('express');
const router=express.Router();
const Input=require('./models/inputschema');

router.post('/history',async(req,res)=>{
    await Input.find({userID:req.body})
});

module.exports=router


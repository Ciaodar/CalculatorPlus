const express = require('express');
const router = express.Router();

const redist=require('../services/cacheredis');

router.get('/ca', async(req,res) => {
    console.log('Geldi')
    const id = req.query.id;
    const response = await redist(id);
    res.json(response);
});

module.exports=router;

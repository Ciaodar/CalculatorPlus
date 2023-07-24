const express = require('express');
const router = express.Router();
const Input = require('../models/inputschema');

router.get('/history',async (req, res) => {
    try {
        const id = req.query.id;
        const found = await Input.find({userId:id});
        res.json(found)
    } catch (error) {
        res.json("bulunamadı");
    }
});

module.exports = router;


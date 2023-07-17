const express = require('express');
const router = express.Router();
const Input = require('../models/inputschema');

router.use(async (req, res) => {
    try {
        var found
        let id = req.body.id;
        console.log(id);
        if (id !== undefined) {
             found = await Input.findById(id).exec();
        } else {
             found = await Input.find().exec();
        } 
        console.log(found)
        res.send(found)
    } catch (error) {
        console.error(error)
    }
});

module.exports = router;


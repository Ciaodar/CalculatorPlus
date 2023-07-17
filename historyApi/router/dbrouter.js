const express = require('express');
const router = express.Router();
const Input = require('../models/inputschema');

router.get('/:id',async (req, res) => {
    try {
        var found
        let id = req.query.id;
        console.log(id);
        found = await Input.findById(id).exec();
        console.log(found)
        res.send(found)
    } catch (error) {
        console.error(error)
    }
});

module.exports = router;


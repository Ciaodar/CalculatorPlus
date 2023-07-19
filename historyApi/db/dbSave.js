const mongoose = require('mongoose');
const Input = require('../models/inputschema');

const dbSave = async(data)=>{
    //the user check whether has made calculation or not with userId
    //....
    //....
    //if not save new calculation or push to existing value
    try{
    const saveData = new Input(data);
    const result = await saveData.save();
    }catch(e){
        console.log(e);
    }
}
module.exports = dbSave;
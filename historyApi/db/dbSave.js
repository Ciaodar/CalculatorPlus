const mongoose = require('mongoose');
const Input = require('../models/inputschema');

const dbSave = async(data)=>{
    var found = Input.find({userId:data.userId});
    if(found){
        await Input.updateOne({},{$push:{Calculations:data.Calculations[0]}});
    }else{
        try{
        const saveData = new Input(data);
        const result = await saveData.save();
        }catch(e){
            console.log(e);
        }
    }
}
module.exports = dbSave;
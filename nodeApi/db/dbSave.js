const mongoose = require('mongoose');
const Input = require('../models/inputschema');

const dbSave = async(data)=>{
    var found = await Input.find({userId:data.userId});
    if(found[0] != null){
        console.log(found);
        await Input.updateOne({userId:data.userId},{$push:{Calculations:data.Calculations[0]}});
        return "Başarıyla yeni veri eklendi"
    }else{
        try{
        const saveData = new Input(data);
        const result = await saveData.save();
        return "Başarıyla yeni veri oluşturuldu"
        }catch(e){
            console.log(e);
        }
    }
}
module.exports = dbSave;
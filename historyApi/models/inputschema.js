const mongoose= require('mongoose');
const schema=mongoose.Schema;

const inputschema=new schema({
    Calculations:[{
        input1:{type: Number,requried:true},
        input2:{type: Number,requried:true},
        result:{type: Number,requried:true},
        signOperation:{type: String,requried:true},}],
},
{collection:"calculationHistory",versionKey:false})

const Input=mongoose.model("Input",inputschema);

module.exports=Input;
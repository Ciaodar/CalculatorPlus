const mongoose= require('mongoose');
const schema=mongoose.Schema;

const inputschema=new schema({
    userID:{type: String, required:true},
    input1:{type: Number,requried:true},
    input2:{type: Number,requried:true},
    operation:{type: String,requried:true},
    result:{type: Number,requried:true}
},{collection:"inputlist",versionKey:false})

const Input=mongoose.model("Input",inputschema);

module.exports=Input;
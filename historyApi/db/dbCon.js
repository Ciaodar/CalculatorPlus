const mongoose = require('mongoose');

//useCreateIndex:true
mongoose.connect("mongodb+srv://gliencherth:jbZpDteXdkXBhtVy@calcp.2xsojvd.mongodb.net/CalculatorIntern",{useNewUrlParser:true,useUnifiedTopology:true})
.then(()=>console.log("Connected to Database succesfully"))
.catch(e=>console.log("Error occured while connecting!! "+e));
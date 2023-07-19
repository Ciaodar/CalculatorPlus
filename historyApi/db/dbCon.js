const mongoose=require('mongoose');

const connectDB = async () => {
    try {
        await mongoose.connect('mongodb+srv://gliencherth:jbZpDteXdkXBhtVy@calcp.2xsojvd.mongodb.net/CalculatorIntern',{
            useUnifiedTopology:true,
            useNewUrlParser:true,
        });
    } catch (error) {
        console.error(error);
    }
}

module.exports = connectDB;
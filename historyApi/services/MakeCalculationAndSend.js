const dbSave = require('../db/dbSave');
const Socket = require('../services/Socket');
const MakeCalculationAndSend = (message)=>{
    const json = JSON.parse(message);
    const data = json.Calculations[0];
    let result;
    switch(data.signOperation){
        case '+':
            result = data.input1 + data.input2;
            break;
        case '-':
            result = data.input1 - data.input2;
            break;
        case '*':
            result = data.input1 * data.input2;
            break;
        case '/':
            result = data.input1 / data.input2;
            break; 
        default:
            result = 0;                 
    }
    const resultValue = {
        userId : json.userId,
        Calculations: [{
            input1 : data.input1,
            input2 : data.input2,
            result : result,
            signOperation:data.signOperation
        }]
    }
    const socketResult ={
        userId : json.userId,
        username : json.username,
        Calculations: [{
            input1 : data.input1,
            input2 : data.input2,
            result : result,
            signOperation:data.signOperation
        }]
    }
    dbSave(resultValue).then(e=>console.log(e)).catch(e=>console.log(e));
    const socketResultStr = JSON.stringify(socketResult);
    Socket.sendCalculationAll(socketResultStr);
    
}

module.exports = MakeCalculationAndSend;

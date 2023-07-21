const dbSave = require('../db/dbSave');
const MakeCalculationAndSend = (message)=>{
    const json = JSON.parse(message);
    const data = json.Calculation[0];
    let result;
    console.log(json.Calculation[0]);
    /*switch(data.signOperation){
        case '+':
            result = data.input1 + data.input2;
            break;
        case '-':
            result = data.input1 - data.input2;
            break;
        case 'x':
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
        Calculation: [{
            input1 : data.input1,
            input2 : data.input2,
            result : result
        }]
    }
    dbSave(resultValue).then(e=>console.log(e)).catch(e=>console.log(e));
    //socket*/
}

module.exports = MakeCalculationAndSend;

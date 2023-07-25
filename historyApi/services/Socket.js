let ALL_USERS = [];

const SocketServer = (wss)=>{
    wss.on('connection',(ws)=>{
        ALL_USERS.push(ws);
        console.log("yeni bağlantı");
        wss.on('close',(ws)=>{
            const id = ALL_USERS.indexOf(ws);
            ALL_USERS.slice(id,1);
        });
        
    })
}
function sendCalculationAll(message){
    console.log(message);
    for(let i = 0;i<ALL_USERS.length;i++){
        ALL_USERS[i].ws.send(message);
    }
}

module.exports = {
    SocketServer:SocketServer,
    sendCalculationAll:sendCalculationAll
}
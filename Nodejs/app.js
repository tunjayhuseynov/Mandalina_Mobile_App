var http = require('http');
var sIo = require('socket.io');
var server = http.createServer(function(req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain', "Access-Control-Allow-Origin": "https://filmdizimob.com",'Access-Control-Allow-Credentials': true});
    var message = 'It works!\n',
        version = 'NodeJS ' + process.versions.node + '\n' + sIo,
        response = [message, version].join('\n');
    res.end(response);
});



const io = sIo(server,{
    handlePreflightRequest: (req, res) => {
        const headers = {
            "Access-Control-Allow-Origin": "https://filmdizimob.com",
            'Access-Control-Allow-Credentials': true}
        res.writeHead(200, headers);
        res.end();
    },
    'pingInterval': 2000, 
    'pingTimeout': 5000
});


io.set('transports', ['polling']);
let liveUserCount = ()=>{
  io.sockets.emit("userCount", io.sockets.adapter.rooms['website']?io.sockets.adapter.rooms['website'].length:0)
}

io.on('connection', (socket) => {
  console.log('Bir kullanıcı bağlandı: ' + socket.id);
  socket.on("user", ()=>{
    socket.join("website")
    liveUserCount()
  })
  
  liveUserCount()
  
  socket.on('disconnect', () => {
    liveUserCount()
    console.log('Bir kullanıcı ayrıldı: ' + socket.id);
  });
});

server.listen();
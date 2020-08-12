const socketIO = require('socket.io');
const io = socketIO.listen(3000);

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


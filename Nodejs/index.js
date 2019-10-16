var express = require('express')
var app = express()
var dbRequest = require("./query")


function Movies(req,res){ 
  var db = new dbRequest.DbRequest();
  var result;
  db.getMoviesByGenre(req.params.genre, parseInt(req.params.start), parseInt(req.params.end)).then(()=>{
    result = dbRequest.result_json
    console.log( dbRequest.result_json)
  });

  
  return res.send( result );
}
function Movie(req,res){ 

  return res.send(dbRequest.getMoviesByGenre(req.params.id));
}

  app.get('/api/movies/:genre/:start/:end', Movies) 
  app.get('/api/movie/:id', Movie) 
 



  var port = 3000
  app.listen(port, () => console.log(`Example app listening on port ${port}!`))
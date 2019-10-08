var MongoClient = require('mongodb').MongoClient;
var express = require('express')
var app = express()
var url = "mongodb://localhost:27017/";

var json;

function ApiHome(req, res){

MongoClient.connect(url, { useNewUrlParser: true , useUnifiedTopology: true}, function(err, db) {
    if (err) throw err;
    var admin= db.db("admin")
    var query = { id: "89" };
    admin.collection("Netflix_Item").find(query).toArray(function(err, result){
        if(err) throw err;
        json = '[ {"title": "Drama", "items": '+JSON.stringify(result)+'}, {"title": "Action", "items": '+JSON.stringify(result)+'}]'
    });
    db.close(); 
  }); 

    return res.send(JSON.parse(json))
}

  app.get('/api/home', ApiHome)




  var port = 3000
  app.listen(port, () => console.log(`Example app listening on port ${port}!`))
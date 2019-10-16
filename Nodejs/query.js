var mysql  = require('mysql');
const delay = require('delay');

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '',
  database : 'mandalina',
  multipleStatements: true
  
});
 
var idOption = {
  sql:`SELECT * FROM movies
  WHERE movies.id = ?;
  `, nestTables: false
}

var genreOption = {sql:`SELECT * FROM movies 
JOIN moviegenres ON moviegenres.movieID = movies.id 
JOIN genres ON moviegenres.genreID = genres.id 
JOIN movieTypes ON movieTypes.id = movies.movieType WHERE genres.name = ? LIMIT ?,?;
`, nestTables: true}

var episodeOption = {sql:`SELECT * FROM episodes
WHERE episodes.movieID = ?;
`, nestTables: false}

var castsOption = {sql:`SELECT * FROM moviecasts
WHERE moviecasts.movieID = ?;
`, nestTables: false}

var genreNames = {sql:`SELECT genres.name FROM moviegenres
JOIN movies ON moviegenres.movieID = movies.id 
JOIN genres ON moviegenres.genreID = genres.id 
WHERE moviegenres.movieID = ?;
`, nestTables: false}

var nameOption = {sql:`SELECT * FROM movies 
JOIN moviegenres ON moviegenres.movieID = movies.id 
JOIN genres ON moviegenres.genreID = genres.id 
JOIN movieTypes ON movieTypes.id = movies.movieType 
JOIN episodes ON  episodes.movieID = movies.id
JOIN moviecasts ON moviecasts.movieID = movies.id WHERE movies.name = ?;`, nestTables: true}

var result_json;

class DbRequest {
      async getMoviesByGenre(genre, count, end){
      connection.query(genreOption, [genre,  count,end], async function (error, results) {
          if (error) throw error;
          result(results)
        })

        
    }
  }

  function result(res){
    var stringJson = JSON.stringify(res);
    return result_json = '[{"title": "anime", "items": '+stringJson+'}]'
  }

module.exports = {
  DbRequest: DbRequest,
  result_json: result_json
};
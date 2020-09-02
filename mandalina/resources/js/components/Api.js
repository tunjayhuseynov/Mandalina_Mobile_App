import axios from 'axios'

var api = axios.create({
    baseURL: `/api`,
    withCredentials: false,
    headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
    }
});


export default {
    getHomeMovies(){
        return api.get('/movies/main')
    },
    getMovieSuggested(){
        return api.get('/suggestedMovie')
    },
    getHomeSeries(){
        return api.get('/series/main')
    },
    getSerieSuggested(){
        return api.get('/suggestedSeries')
    },
    getSearch(val){
        return api.get(`/search/${val}`)
    },
    getMovie(val){
        return api.get(`/movie/${val}`)
    },
    getCategory(type, genre, start, end){
        return api.get(`/${type}/${genre}/${start}/${end}`)
    },
    getAllCategories(){
        return api.get('/genres')
    }
}
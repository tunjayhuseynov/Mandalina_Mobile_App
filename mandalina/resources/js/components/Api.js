import axios from 'axios'

var api = axios.create({
    baseURL: `/api`,
    withCredentials: false,
    headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'auth': "5591980supertun"
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
    }
}
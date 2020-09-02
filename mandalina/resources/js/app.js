/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');
import router from './router'


window.Vue = require('vue');
window.Vuex = require('vuex');

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

// const files = require.context('./', true, /\.vue$/i)
// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))


Vue.component('player', require('./components/mainComponents/Player.vue').default);
Vue.component('home', require('./components/rootComponents/Home.vue').default);
Vue.component('navbar', require('./components/mainComponents/homeComponents/Navbar.vue').default);
Vue.component('headerbar', require('./components/mainComponents/homeComponents/Header.vue').default);
Vue.component('bodybar', require('./components/mainComponents/homeComponents/Body.vue').default);
Vue.component('genrebar', require('./components/mainComponents/homeComponents/GenreBar.vue').default);
Vue.component('carousel', require('./components/mainComponents/homeComponents/Carousel.vue').default);
Vue.component('loading', require('./components/subcomponents/Loading.vue').default);
Vue.component('mainpart', require('./components/sideComponents/Mainpart.vue').default);
Vue.component('movies', require('./components/sideComponents/Movies.vue').default);
Vue.component('search', require('./components/mainComponents/homeComponents/Search.vue').default);
Vue.component('series', require('./components/sideComponents/Series.vue').default);
Vue.component('aboutmovie', require('./components/mainComponents/AboutMovie.vue').default);
Vue.component('category', require('./components/mainComponents/Category.vue').default);
Vue.component('playerbtn', require('./components/subcomponents/Playerbtn.vue').default);
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

const store = new Vuex.Store({
  state: {
    homeMovies: null,
    homeSeries: null,
    movieSuggested: null,
    serieSuggested: null,
    searchQuery: null,
    searchResult: null,
    searchPath: null,
    searchBox: null,
    allGenres: null,
    metaTag(title, description, keywords){
      document.title = title || this.metaTitle;
      
      let metaDes  = document.createElement("meta")
      document.head.appendChild(metaDes)
      metaDes.setAttribute("name", "description")
      metaDes.setAttribute("content", description || this.metaDescription)

      let metaKey  = document.createElement("meta")
      document.head.appendChild(metaKey)
      metaKey.setAttribute("name", "keywords")
      metaKey.setAttribute("content", keywords || this.metaKey)
      
    },
    metaTitle: "FilmDiziMob.Com - Yeni Nesil Film Sitesi",
    metaDescription: "",
    metaKey: ""
  },
  mutations: {
    setHomeMovies(state, data) {
      state.homeMovies = data
    },
    setHomeSeries(state, data) {
      state.homeSeries = data
    },
    setMovieSuggested(state, data) {
      state.movieSuggested = data
    },
    setSerieSuggested(state, data) {
      state.serieSuggested = data
    },
    setSearchQuery(state, data){
      state.searchQuery = data
    },
    setSearchResult(state, data){
      state.searchResult = data
    },
    setSearchPath(state, data){
      state.searchPath = data
    },
    setSearchBox(state, data){
      state.searchBox = data
    },
    setAllGenres(state, data){
      state.allGenres = data
    }
  },
})

const app = new Vue({
  el: '#app',
  store: store,
  router,
});

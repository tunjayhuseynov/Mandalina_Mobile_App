require('./bootstrap');
import router from './router'

function urlB64ToUint8Array(base64String) {
  const padding = '='.repeat((4 - base64String.length % 4) % 4);
  const base64 = (base64String + padding)
    .replace(/\-/g, '+')
    .replace(/_/g, '/');

  const rawData = window.atob(base64);
  const outputArray = new Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
}

if ('serviceWorker' in navigator) {
  window.addEventListener('load', function () {
    navigator.serviceWorker.register('/sw.js')
      .then(() => navigator.serviceWorker.ready)
      .then(async (registration) => {
        let applicationServerPublicKey = "BCPvEAXQZEv1ONndaYOg6_SKfn_b3xgfSHQyN-iinf2Fa6c6g7iRyTi69_EdpTydZoudEzVYq2-vZHRXuC1KZGA"

        const applicationServerKey = urlB64ToUint8Array(applicationServerPublicKey);
        
        let sub = await registration.pushManager.subscribe({
          userVisibleOnly: true,
          applicationServerKey: applicationServerKey
        })

        let contentEncoding = (PushManager.supportedContentEncodings || ['aesgcm'])[0];
       
        let reciver = {
          endpoint: sub.endpoint,
          keys: {
            p256dh: sub.toJSON().keys.p256dh,
            auth: sub.toJSON().keys.auth
          },
          contentEncoding: contentEncoding
        }

        fetch("/subscribeToPush", {
          body: JSON.stringify(reciver), method: "POST", headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
          }
        })
      })
  });
}

window.Vue = require('vue');
window.Vuex = require('vuex');

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
    metaTag(title, description, keywords) {
      document.title = title || this.metaTitle;

      let metaDes = document.createElement("meta")
      document.head.appendChild(metaDes)
      metaDes.setAttribute("name", "description")
      metaDes.setAttribute("content", description || this.metaDescription)

      let metaKey = document.createElement("meta")
      document.head.appendChild(metaKey)
      metaKey.setAttribute("name", "keywords")
      metaKey.setAttribute("content", keywords || this.metaKey)

    },
    metaTitle: "Filmdizimob.com - Yeni Nesil Film Sitesi",
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
    setSearchQuery(state, data) {
      state.searchQuery = data
    },
    setSearchResult(state, data) {
      state.searchResult = data
    },
    setSearchPath(state, data) {
      state.searchPath = data
    },
    setSearchBox(state, data) {
      state.searchBox = data
    },
    setAllGenres(state, data) {
      state.allGenres = data
    }
  },
})

const app = new Vue({
  el: '#app',
  store: store,
  router,
});

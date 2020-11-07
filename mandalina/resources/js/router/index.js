import Vue from 'vue'
import Router from 'vue-router'
import Player from '../components/mainComponents/Player'
import Home from '../components/rootComponents/Home'
import Movies from '../components/sideComponents/Movies'
import Series from '../components/sideComponents/Series'
import Search from '../components/mainComponents/homeComponents/Search'
import AboutMovie from '../components/mainComponents/AboutMovie'
import Category from '../components/mainComponents/Category'

Vue.use(Router)

export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/izle/:type/:id/:movieName',
            name: 'Player',
            component: Player,
        },
        {
            path: '/',
            component: Home,
            children: [
                {
                    path: '',
                    name: 'Movies',
                    component: Movies 
                },
                {
                    path: 'movie',
                    name: 'Movies',
                    component: Movies,
                },
                {
                    path: 'category/:type/:category',
                    name: 'Category',
                    component: Category,
                },
                {
                    path: 'tvshows',
                    name: 'Series',
                    component: Series 
                },
                {
                    path: 'search',
                    name: 'Search',
                    component: Search 
                },
                {
                    path: 'about/:id/:moviename',
                    name: 'MovieInfo',
                    component: AboutMovie,
                    meta: { transitionName: 'slide' }
                }
            ]
        },

    ],
})
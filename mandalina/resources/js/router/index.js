import Vue from 'vue'
import Router from 'vue-router'
import Player from '../components/Player'
import Home from '../components/Home'
import Movies from '../components/Movies'
import Series from '../components/Series'
import Search from '../components/Search'
import AboutMovie from '../components/AboutMovie'
import Category from '../components/Category'

Vue.use(Router)

export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/#player?link=:link&movie=:id',
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
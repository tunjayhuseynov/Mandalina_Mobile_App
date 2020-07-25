import Vue from 'vue'
import Router from 'vue-router'
import Player from '../components/Player'
import Home from '../components/Home'
import Mainpart from '../components/Mainpart'

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
                    path: 'movie',
                    name: 'Movies',
                    component: Mainpart 
                },
                {
                    path: 'tvshows',
                    name: 'Series',
                    component: Mainpart 
                }
            ]
        },

    ]
})
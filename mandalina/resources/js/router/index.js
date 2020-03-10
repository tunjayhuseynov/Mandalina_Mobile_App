import Vue from 'vue'
import Router from 'vue-router'
import Player from '../components/Player'
import Home from '../components/Home'

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
            name: 'Home',
            component: Home,
        }
    ]
})
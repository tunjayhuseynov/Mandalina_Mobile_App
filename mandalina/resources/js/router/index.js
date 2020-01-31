import Vue from 'vue'
import Router from 'vue-router'
import VideoPlayer from '../components/Player'
import Home from '../components/Home'

Vue.use(Router)

export default new Router({
    mode: 'hash',
    routes: [
        {
            path: '/player',
            name: 'VideoPlayer',
            component: VideoPlayer,
            props: true
        },
        {
            path: '/',
            name: 'Home',
            component: Home,
        }
    ]
})
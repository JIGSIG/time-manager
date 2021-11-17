import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from "../components/Login";
import Home from "../components/Home";
// import axios from "axios";

Vue.use(VueRouter)

// const routes = [
//   {
//     path: '/',
//     name: 'Home',
//     components: {
//     }
//   },
//   {
//     path: '/workingTimes',
//     name: 'WorkingTimes',
//     // component: User
//   },
//   {
//     path: '/workingTime/:userid/:workingtimeid',
//     name: 'WorkingTime',
//     // component: WorkingTime,
//   },
//   {
//     path: '/clock/:username',
//     name: 'ClockManager',
//     // component: ClockManager,
//   },
//   {
//     path: '/chartManager/:userid',
//     name: 'Chart Manager',
//     // component: ChartManager,
//   },
// ]

const homeRoleRouting = (to, from, next) => {
    const token = localStorage.getItem('user-token') || undefined
    if (token !== undefined) {
        next()
        return
    }
    next('/login')
}

const  routes = [
    {
        path: '/',
        name: 'Home',
        component: Home,
        beforeEnter: homeRoleRouting,
    },
    {
        path: '/login',
        name: 'Login',
        component: Login,
        beforeEnter: (to, from, next) => {
            const token = localStorage.getItem('user-token') || undefined
            if (token === undefined) {
                next()
                return
            }
            next('/')
        },
    },
]
// route level code-splitting
// this generates a separate chunk (about.[hash].js) for this route
// which is lazy-loaded when the route is visited.
// component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router

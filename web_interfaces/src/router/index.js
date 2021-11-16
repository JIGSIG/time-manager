import Vue from 'vue'
import VueRouter from 'vue-router'
import WorkingTimes from "../components/WorkingTimes";
import WorkingTime from "../components/WorkingTime";
import User from "../components/User";
import ClockManager from "../components/ClockManager";
import ChartManager from "../components/ChartManager";
import Registration from "../components/User/Registration";
import Login from "../components/User/Login";
import Profile from "../components/User/Profile";

Vue.use(VueRouter)

const routes = [
  {
    path: '/signup',
    name: 'Register',
    component: Registration,
    public: true,
  },
  {
    path: '/signin',
    name: 'Login',
    component: Login,
    public: true,
  },
  {
    path: '/profile',
    name: 'Profile',
    component: Profile,
  },
  {
    path: '/',
    name: 'Home',
    components: {
      default: ChartManager,
      a: User,
      b: WorkingTimes,
      c: ClockManager,
      d: ChartManager
    },
  },
  {
    path: '/users',
    name: 'Users',
    component: User
  },
  {
    path: '/workingTimes/:userId',
    name: 'WorkingTimes',
    component: WorkingTimes
  },
  {
    path: '/workingTime/:userid/:workingtimeid',
    name: 'WorkingTime',
    component: WorkingTime,
  },
  {
    path: '/clock/:username',
    name: 'ClockManager',
    component: ClockManager,
  },
  {
    path: '/chartManager/:userid',
    name: 'Chart Manager',
    component: ChartManager,
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

router.beforeEach((to, from, next)=>{
  const token = localStorage.getItem('user-token')
  if ( to.path !== '/signin' && to.path !== '/signup' && !token ){
    next({
      path: '/signin',
      replace: true
    })
  } else {
    next();
  }
})

export default router

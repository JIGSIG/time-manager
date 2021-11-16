import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store/store'
import vuetify from './plugins/vuetify'
import axios from 'axios'

Vue.config.productionTip = false
Vue.prototype.$api = axios.create({
  baseURL: 'http://127.0.0.1:4000/api'
})

new Vue({
  vuetify,
  router,
  store,

  render: h => h(App)
}).$mount('#app')

import Vue from 'vue'
import Vuex from 'vuex'
import userModule from './modules/user_component_module'
import workingtimesModule from './modules/workingtimes_component_module'
import chartModule from './modules/chart_component_module'
import clockModule from './modules/clock_component_module'

Vue.use(Vuex)

export default new Vuex.Store({
    modules: {
        userModule,
        workingtimesModule,
        chartModule,
        clockModule,
    }
})

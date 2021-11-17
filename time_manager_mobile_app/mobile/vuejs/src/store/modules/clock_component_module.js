import apiClient from "../../router/apiClient";

const state = () => ({
    lastClock: {
        status: false
    },
})

const actions = {
    setClockForSelectedUser({ commit }, id) {
        apiClient.post(`/clocks/${id}`)
            .then(response => {
                commit('updateClock', {clock: response.data["data"]})
            })
            .catch(error => {
                    console.log("OOSOSOSOSS")
                    console.log(error.message)
            })
    },

    getClockForSelectedUser({ commit }, id) {
        apiClient.get(`/clocks/${id}`)
            .then(response => {
                commit('updateClock', {clock: response.data["data"]})
            })
            .catch(error => {console.log(error)})
    },

}

const mutations = {

    updateClock(state, { clock }) {
        if (clock !== null)
            state.lastClock = clock
    },

}

const getters = {
    lastClock: state => state.lastClock,
}

export default {
    namespaced: true,
    state,
    actions,
    mutations,
    getters,
}
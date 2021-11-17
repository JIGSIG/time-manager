import apiClient from "../../router/apiClient";

const state = () => ({
    currentWorkingTimes: [],
    currentWorkingTime: {},
    events: []
})

const actions = {

    getAllWorkingTimesForSelectedUser({ commit }, data) {
        const user = data.user
        const start = data.start
        const end = data.end

        apiClient.get(`/workingtimes/${user.id}?start=${start}&end=${end}`, )
            .then(response => {
                commit('updateWorkingTimes', { workingtimes: response.data["data"]})
            })
            .catch(error => {
                if (user.id === undefined)
                    commit('updateWorkingTimes', { workingtimes: [] })
                console.log(error)
            })
    },

    createWorkingTimeForSelectedUser({ commit }, data) {
        const user = data.user
        const start = data.start
        const end = data.end

        apiClient.post(`/workingtimes/${user.id}`, {start, end})
            .then(response => {
                commit('addToWorkingTimesList', { workingtime: response.data["data"]})
            })
            .catch(error => {console.log(error)})
    },

    updateWorkingTimeForSelectedUser({ commit }, data) {
        const event = data.event
        const start = data.start
        const end = data.end

        apiClient.put(`/workingtimes/${event.id}`, {start, end})
            .then(response => {
                commit('updateToWorkingTimesList', { workingtime: response.data["data"]})
            })
            .catch(error => {console.log(error)})
    },

    deleteWorkingTimeForSelectedUser({ commit }, data) {
        apiClient.delete(`/workingtimes/${data.id}`)
            .then(() => {
                commit('removeFromWorkingTimeList', {workingtime: data})
            })
            .catch(error => {console.log(error)})
    },

    getWorkingTimeForSelectedUser({ commit }, id) {
        apiClient.get(`/workingtimes/${id}`)
            .then(response => {
                commit('getWorkingTime', {workingtime: response.data["data"]})
            })
            .catch(error => {console.log(error)})
    },

}

const mutations = {
    updateWorkingTimes(state, { workingtimes }) {
        state.events = []
        state.currentWorkingTimes = workingtimes
        for (let i = 0; i < workingtimes.length; i++) {
            const first = new Date(workingtimes.at(i).start)
            const second = new Date(workingtimes.at(i).end)
            state.events.push({
                id: workingtimes.at(i).id,
                name: 'WorkingTime ' + workingtimes.at(i).id,
                start: first,
                end: second,
                color: 'blue',
                timed: true,
            })
        }
    },

    addToWorkingTimesList(state, {workingtime}) {
        state.currentWorkingTimes = state.currentWorkingTimes.push(workingtime)
        const first = new Date(workingtime.start)
        const second = new Date(workingtime.end)
        state.events.push({
            id: workingtime.id,
            name: 'WorkingTime ' + workingtime.id,
            start: first,
            end: second,
            color: 'blue',
            timed: true,
        })
    },

    updateToWorkingTimesList(state, {workingtime}) {
        let objIndex1 = state.currentWorkingTimes.findIndex((obj => obj.id === workingtime.id));
        Object.assign(state.currentWorkingTimes[objIndex1], workingtime)
        let objIndex2 = state.events.findIndex((obj => obj.id === workingtime.id));
        Object.assign(state.events[objIndex2], workingtime)
        let events = state.events
        state.events = []
        state.events = events
    },

    removeFromWorkingTimeList(state, { workingtime }) {
        for( let i = 0; i < state.currentWorkingTimes.length; i++){
            if ( state.currentWorkingTimes[i].id === workingtime.id) {
                state.currentWorkingTimes.splice(i, 1);
            }
        }

        for( let i = 0; i < state.events.length; i++){
            if ( state.events[i].id === workingtime.id) {
                state.events.splice(i, 1);
            }
        }
    },


    getWorkingTime(state, {workingtime}) {
        state.currentWorkingTime = workingtime
    },
}

const getters = {
    events: state => state.events,
    selectedWorkingTime: state => state.currentWorkingTime
}

export default {
    namespaced: true,
    state,
    actions,
    mutations,
    getters,
}
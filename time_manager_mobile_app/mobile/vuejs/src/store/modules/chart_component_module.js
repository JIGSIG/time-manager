import apiClient from "../../router/apiClient";

const state = () => ({
    clocks: [],
    workingTimes: [],
    workedHoursPerMonth: [],
    scheduledWorkHoursPerMonth: [],
})

const actions = {
    getAllClockForUser({ commit }, user) {
        apiClient.get('/clocks/' + user.id + '?all=true')
        .then(r => {
            commit('updateClocks', {clocks: r.data["data"]})
        })
        .catch(e => {
            if (user.id === undefined)
                commit('updateClocks', { clocks: [] })

            console.log(e)
        })
    },

    getAllWorkingTimesForSelectedUser({ commit }, user) {
        const date = new Date()
        const start = date.getFullYear()+"-01-01" + " 00:00:00"
        const end = date.getFullYear()+"-12-31" + " 23:59:59"

        apiClient.get(`/workingtimes/${user.id}?start=${start}&end=${end}`, )
            .then(response => {
                commit('updateWorkingTimes', { workingtimes: response.data["data"]})
            })
            .catch(error => {
                if (user.id === undefined)
                    commit('updateWorkingTimes', { workingtimes: [] })
                console.log(error)
            })
    }
}

const mutations = {
    updateClocks(state, { clocks }) {
        if (clocks === null) return;
        state.clocks = clocks
        let pairClocks = []
        for (let i = 0; i < clocks.length - (clocks.length % 2 === 0 ? 0 : 1); i += 2) {
            let duo = {
                in: (clocks[i]),
                out: (clocks[i + 1])
            }
            pairClocks.push(duo)
        }
        if (clocks.length % 2 !== 0) {
            let date = new Date();
            let time = date.toISOString().slice(0,10);
            let duo = {
                in: (clocks[clocks.length - 1]),
                out: {
                    "time": time + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds(),
                    "status": false,
                    "id": clocks[clocks.length - 1]?.id + 1
                }
            }
            pairClocks.push(duo)
        }
        const date = new Date()
        state.workedHoursPerMonth = []
        for (let month = 1; month <= 12; month++ ) {
            let monthString = month < 10 ? "0"+month : month.toString()
            let start = new Date( date.getFullYear() + "-" + monthString + "-01 00:00:00").getTime()
            let end = new Date( date.getFullYear() + "-" + monthString + "-31 23:59:59").getTime()
            let total = 0
            for (let i = 0; i < pairClocks.length; i++) {
                let fTime = new Date(pairClocks[i].in.time).getTime()
                let lTime = new Date(pairClocks[i].out.time).getTime()
                if (fTime >= start && lTime <= end) {
                    const seconds = Math.floor((lTime - fTime) / 1000)
                    total += (seconds / 3600)
                }
            }
            state.workedHoursPerMonth.push(total)
        }
        if (state.workedHoursPerMonth === [])
            state.workedHoursPerMonth = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    },

    updateWorkingTimes(state, { workingtimes }) {
        state.workingTimes = workingtimes
        const date = new Date()
        state.scheduledWorkHoursPerMonth = []
        for (let month = 1; month <= 12; month++ ) {
            let monthString = month < 10 ? "0"+month : month.toString()
            let start = new Date( date.getFullYear() + "-" + monthString + "-01 00:00:00").getTime()
            let end = new Date( date.getFullYear() + "-" + monthString + "-31 23:59:59").getTime()
            let total = 0
            for (let i = 0; i < workingtimes.length; i++) {
                let fTime = new Date(workingtimes[i].start).getTime()
                let lTime = new Date(workingtimes[i].end).getTime()
                if (fTime >= start && lTime <= end) {
                    const seconds = Math.floor((lTime - fTime) / 1000)
                    total += (seconds / 3600)
                }
            }
            state.scheduledWorkHoursPerMonth.push(total)
        }
        if (state.scheduledWorkHoursPerMonth === [])
            state.scheduledWorkHoursPerMonth = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
}

const getters = {
    lineChartGetter: state => state.workedHoursPerMonth,
    barChartGetter: state => [state.workedHoursPerMonth, state.scheduledWorkHoursPerMonth],
    doughnut_chart_data: state => [state.workedHoursPerMonth[new Date().getMonth()], state.scheduledWorkHoursPerMonth[new Date().getMonth()]],
}

export default {
    namespaced: true,
    state,
    actions,
    mutations,
    getters,
}
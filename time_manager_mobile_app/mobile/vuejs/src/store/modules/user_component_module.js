import axios from "axios";
import router from "../../router";
import apiClient from "../../router/apiClient";

const state = () => ({
    connectedUser: JSON.parse(localStorage.getItem('user')),
    currentSelectedUser: {},
    token:  localStorage.getItem('user-token') || undefined,
    errorStatus: false,
    errorMessage: '',
    userList: [],
})

const actions = {

    register({ commit }, data) {
        apiClient.post('/registration/signup', data)
            .then(response => {
                commit('updateToken', {token: response.data.token})
                commit('updateConnectedUser', {user: response.data.user})
                localStorage.setItem('user-token', response.data.token)
                localStorage.setItem('user', JSON.stringify(response.data.user))
                axios.defaults.headers.common['Authorization'] = "Bearer " + response.data.token
                router.push({path: '/'}).then(r => console.log(r))
            })
            .catch(err => {
                console.log(err)
                commit('updateToken', {token: undefined})
                commit('updateErrorStatus', err)
            })
    },

    login({ commit }, data) {
        apiClient.post('/registration/signin', data)
            .then(response => {
                commit('updateToken', {token: response.data.token})
                commit('updateConnectedUser', {user: response.data.user})
                localStorage.setItem('user-token', response.data.token)
                localStorage.setItem('user', JSON.stringify(response.data.user))
                axios.defaults.headers.common['Authorization'] = "Bearer " + response.data.token
                router.push({path: '/'}).then(r => console.log(r))
            })
            .catch(err => {
                console.log(err)
                commit('updateToken', {token: undefined})
                commit('updateErrorStatus', err)
            })
    },

    disconnect({ commit }) {
        commit('updateToken', {token: undefined})
        localStorage.removeItem('user-token')
        localStorage.removeItem('user')
        delete axios.defaults.headers.common['Authorization']
        router.replace({path: '/login'}).then(r => console.log(r))
    },

    createUser({ commit }, data) {
        apiClient.post('/users', data)
            .then(response => {
                commit('addToUserList', {user: response.data["data"]})
            })
            .catch(error => {
                commit('updateErrorStatus', error)
            })
    },

    updateUserById({ commit }, data) {
        apiClient.put('/users/' + data.id, data)
            .then(response => {
                commit('updateUserInUserList', {user: response.data["data"]})
            })
            .catch(error => {
                commit('updateErrorStatus', error)
            })
    },

    getAllUsers({ commit }) {
        apiClient.get('/users/')
            .then(response => {
                commit('setListOfUser', {users: response.data["data"]})
            })
            .catch(error => {
                commit('updateErrorStatus', error)
            })
    },

    getUserById({ commit }, id) {
        apiClient.get('/users/' + id)
            .then(response => {
                commit('getUserById', {user: response.data["data"]})
            })
            .catch(error => {
                if (id === undefined)
                    commit('getUserById', {user: {}})
                commit('updateErrorStatus', error)
            })
    },

    deleteUserById({ commit }, data) {
        apiClient.delete('/users/' + data.id)
            .then(() => {
                commit('removeFromUserList', {user: data})
            })
            .catch(error => {
                commit('updateErrorStatus', error)
            })
    },

}

const mutations = {

    updateToken(state, { token }) {
        state.loggedIn = token !== undefined
        state.token = token
    },

    updateConnectedUser(state, { user }) {
        state.connectedUser = user
    },

    addToUserList(state, { user }) {
        state.userList.push(user)
    },

    updateUserInUserList(state, { user }) {
        let objIndex = state.userList.findIndex((obj => obj.id === user.id));
        Object.assign(state.userList[objIndex], user)
    },

    setListOfUser(state, { users }) {
        state.userList = users;
    },

    getUserById(state, { user }) {
        state.currentSelectedUser = user;
    },

    removeFromUserList(state, { user }) {
        for( let i = 0; i < state.userList.length; i++){
            if ( state.userList[i].id === user.id) {
                state.userList.splice(i, 1);
            }
        }
    },

    updateErrorStatus(state, error) {
        state.errorStatus = true
        state.errorMessage = error.message
        setTimeout(() => {
            state.errorStatus = false;
            state.errorMessage = ''
        }, 3000);
    }
}

const getters = {
    token: state => state.token,
    user: state => state.connectedUser,
    userList: state => state.userList,
    selectedUser: state => state.currentSelectedUser,
    error: state => ({
        'status': state.errorStatus,
        'message': state.errorMessage
    })
}

export default {
    namespaced: true,
    state,
    actions,
    mutations,
    getters,
}
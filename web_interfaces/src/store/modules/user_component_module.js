import router from '../../router'
import apiClient from '../../config/apiConfig'


const state = () => ({
    connectedUser: JSON.parse(localStorage.getItem('user')),
    currentSelectedUser: {},
    currentToken: localStorage.getItem('user-token'),
    errorStatus: false,
    errorMessage: '',
    userList: [],
})

const actions = {

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
            .then(response => {
                commit('removeFromUserList', {user: data})
                console.log(response)
            })
            .catch(error => {
                commit('updateErrorStatus', error)
            })
    },
    registerUser({commit}, data) {
        apiClient.post('/registration/signup', data)
            .then(response => {
                commit('registration', {user: data})
                console.log(response)
            })
            .catch(error => {
                commit('updateErrorStatus', error)
            })
    },

    loginUser({commit}, data) {
        apiClient.post('/registration/signin', data)
            .then(response => {
                commit('updateUser', response.data.user)
                commit('updateToken', response.data.token)
                localStorage.setItem('user-token', response.data.token)
                localStorage.setItem('user', JSON.stringify(response.data.user))
                router.push({ path: '/' })
            })
            .catch(error => {
                commit("updateErrorStatus", error)
            })
    }

}

const mutations = {

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

    updateErrorStatus(state, message) {
        state.errorStatus = !(state.errorStatus)
        state.errorMessage = message
    },

    registration(state, user) {
        state.currentSelectedUser = user;
    },

    updateUser(state, user) {
        state.connectedUser = user;
    },

    updateToken(state, token) {
        state.currentToken = token;
    },

/*    disconnection(state, message) {

    },*/

}

const getters = {
    userList: state => state.userList,
    selectedUser: state => state.currentSelectedUser,
    currentToken: state => state.currentToken,
    connectedUser: state => state.connectedUser,
    errorStatus: state => state.errorStatus,
    errorMessage: state => state.errorMessage,
}

export default {
    namespaced: true,
    state,
    actions,
    mutations,
    getters,
}
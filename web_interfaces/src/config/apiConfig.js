//api-client.js

import axios from 'axios'
import store from '../store/store'

const apiClient = axios.create({
    withCredentials: false, // This is the default
    baseURL: 'http://127.0.0.1:4000/api',
    headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json'
    }
});

apiClient.interceptors.request.use(function (config) {
    // Do something before request is sent
    let authKey = store.getters["userModule/currentToken"]
    config.headers["Authorization"] = "Bearer " + authKey;
    return config;
});

export default apiClient;
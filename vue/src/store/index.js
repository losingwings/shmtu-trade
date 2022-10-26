
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    token: '',
    userId: '',
    superuser: ''
  },
  mutations: {
    //存储token方法
    //设置token等于外部传递进来的值
    setToken(state, token) {
      state.token = token
      localStorage.token = token //同步存储token至localStorage
    },
    //存储用户id
    setUserId(state, userId) {
      state.userId = userId
      localStorage.userId = userId
    },
    //存储用户权限
    setSuperuser(state, superuser) {
      state.superuser = superuser
      localStorage.superuser = superuser
    }
  },
  getters: {
    //获取token方法
    //判断是否有token,如果没有重新赋值，返回给state的token
    getToken(state) {
      if (!state.token) {
        state.token = localStorage.getItem('token')
      }
      return state.token
    },
    getUserId(state) {
      if (!state.userId) {
        state.userId = localStorage.getItem('userId')
      }
      return state.userId
    },
    getSuperuser(state) {
      if (!state.superuser) {
        state.superuser = localStorage.getItem('superuser')
      }
      return state.superuser
    }
  },
  actions: {
  },
  modules: {
  }
})

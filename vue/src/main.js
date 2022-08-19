import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import './style/common.css'
import ElementUI from 'element-ui';
import "element-ui/lib/theme-chalk/index.css"
import 'element-ui/lib/theme-chalk/display.css'
import axios from 'axios'
import request from "@/utils/request";



Vue.config.productionTip = false

Vue.prototype.request=request
    axios.defaults.baseURL = "http://localhost:8081"


Vue.use(ElementUI)



new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')

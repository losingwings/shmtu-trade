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

Vue.use(ElementUI,{size:"min"})

Vue.config.productionTip = false

axios.defaults.baseURL = "http://localhost:8081"

Vue.prototype.request=request
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')

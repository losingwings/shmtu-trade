import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store'
import axios from 'axios'

Vue.use(VueRouter)

const routes = [
  {//管理员页面
    path: '/admin',
    name: '用户管理',
    component: () => import("../views/Admin/Admin.vue"),
    beforeEnter: (to, from, next) => {
      let superuser = store.getters.getSuperuser;
      if (superuser == 1) {
        next()
      } else {
        next({ path: '/' })//跳转到登录页
      }
    },
    show: true,
    redirect: "/findAllUser",
    children: [//子路由
      {//查找所有用户
        path: "/findAllUser",
        name: "查找用户",
        component: () => import("../views/Admin/FindAllUser.vue"),
        show: true
      },
      {//增加用户
        path: "/addUser",
        name: "增加用户",
        component: () => import("../views/Admin/AdminAddUser.vue"),
        show: true
      },
      {//更新用户信息
        path: "/updateUser",
        name: "更新用户",
        component: () => import("../views/Admin/UpdateUser.vue"),
        show: false
      }
    ]
  },//商品管理
  {
    path: "/goods",
    name: "商品管理",
    component: () => import("../views/Admin/Admin.vue"),
    beforeEnter: (to, from, next) => {
      let superuser = store.getters.getSuperuser;
      if (superuser == 1) {
        next()
      } else {
        next({ path: '/' })
      }
    },
    show: true,
    redirect: "/findAllGoods",
    children: [
      {//查找所有商品
        path: "/findAllGoods",
        name: "查找商品",
        component: () => import("../views/Admin/FindAllGoods.vue"),
        show: true
      },
      {//增加商品
        path: "/adminAddGoods",
        name: "增加商品",
        component: () => import("../views/Admin/AdminAddGoods.vue"),
        show: true
      },
      {//更新商品
        path: "/updateGoods",
        name: "更新商品",
        component: () => import("../views/Admin/UpdateGoods.vue"),
        show: false
      }
    ]
  },
  {//登录页
    path: '/',
    name: 'Login',
    component: () => import('../views/Login.vue')
  },
  {//找回密码
    path: '/lostPwd',
    name: 'LostPwd',
    component: () => import('../views/LostPwd.vue')
  },
  {//购物主页
    path: '/home',
    name: 'Home',
    component: () => import('../views/Home.vue'),
    redirect: '/allGoods',
    children: [//子路由
      {//所有商品
        path: "/allGoods",
        name: "AllGoods",
        component: () => import('../views/AllGoods.vue')
      },
      {//商品详情
        path: "/goodsDetail",
        name: "GoodsDetail",
        component: () => import('../views/GoodsDetail.vue')
      },
      {//购买商品
        path: "/toPay",
        name: "ToPay",
        component: () => import('../views/ToPay.vue')
      },
      {//重新购买
        path: "/rePay",
        name: "ToPay",
        component: () => import('../views/RePay.vue')
      },
      {//添加商品
        path: "/addGoods",
        name: "AddGoods",
        component: () => import('../views/AddGoods.vue')
      },
      {//我的购买
        path: "/myPurchase",
        name: "MyPurchase",
        component: () => import('../views/MyPurchase.vue')
      },
      {//我的卖出
        path: "/mySell",
        name: "MySell",
        component: () => import('../views/MySell.vue')
      },
      {//我的收藏
        path: "/bookmark",
        name: "Bookmark",
        component: () => import('../views/Bookmark.vue')
      },
      {//搜索商品
        path: "/search",
        name: "Search",
        component: () => import('../views/Search.vue')
      }
    ]
  },
  {//个人信息页
    path: '/center',
    name: 'Center',
    component: () => import("../views/Center.vue")
  },
  {//测试页
    path: '/test',
    name: 'Test',
    component: () => import("../views/Test.vue")
  }
]


const router = new VueRouter({
  routes
})

//路由守卫，发起token验证，限制页面访问
router.beforeEach((to, from, next) => {
  //获取token
  let token = store.getters.getToken
  if (token == "") {//如果没有token
    if (to.path == "/") {//如果已经是登录页
      next()
    } else {//否则不是登录页
      next({ path: '/' })//跳转到登录页
    }
  } else {//如果有token，就校验token合法性
    axios({
      url: '/checkToken',
      method: 'get',
      headers: {
        token: token
      }
    }).then((response) => {
      if (!response.data) {
        store.commit("setToken", "")//校验失败，移除token
        next({ path: '/' })
      }
    })
    next()
  }
})

//定位浏览器高度
router.afterEach((to, from, next) => {
  window.scrollTo(0, 0);
})

//防止同个路由重复跳转报错
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
    return originalPush.call(this, location).catch(err => err)
}

export default router


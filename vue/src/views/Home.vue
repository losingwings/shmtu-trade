<template>
  <div class="home">
    <el-container>
      <el-header>
        <div class="logo"><span @click="toHome">校园二手平台</span></div>
        <div class="search">
          <el-input
            prefix-icon="el-icon-search"
            placeholder="搜索商品"
            v-model="input"
            @keyup.enter.native="search"
          ></el-input>
        </div>
        <div class="user-info">
          <!-- 按钮组 -->
          <div class="bookmark">
            <el-button
              type="primary"
              icon="el-icon-plus"
              circle
              @click="addGoodsBtn()"
            ></el-button>
            <el-button
              type="warning"
              icon="el-icon-shopping-cart-full"
              circle
              @click="myPurchaseBtn()"
            ></el-button>
            <el-button
              type="warning"
              icon="el-icon-sell"
              circle
              @click="mySellBtn()"
            ></el-button>
            <el-button
              type="warning"
              icon="el-icon-star-off"
              circle
              @click="bookmarkBtn()"
            ></el-button>
          </div>
          <el-dropdown @command="handleCommand">
            <div class="avatar">
              <img v-if="!isLogin" :src="user.avatarUrl" alt="" />
              <img v-else src="../assets/avatar.png" alt="" />
            </div>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item command="toCenter"
                >账户：{{ user.nickname}}</el-dropdown-item
              >
              <el-dropdown-item command="toCenter"
                >余额：￥{{ user.money }}</el-dropdown-item
              >
              <el-dropdown-item command="toPassword">修改密码</el-dropdown-item>
              <el-dropdown-item command="toCenter">更多信息</el-dropdown-item>
              <el-dropdown-item command="logout" divided
                >退出登录</el-dropdown-item
              >
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </el-header>
      <!-- 路由嵌套 -->
      <router-view />
      <el-footer height="200px">
        <div>Copyright © 2022 校园二手交易平台</div>
        <div class="link">
          <div @click="toAdmin">管理员页面</div>
          &nbsp;&nbsp;|&nbsp;&nbsp;
          <div>官方微博</div>
        </div>
        <div style="font-size: 12px">
          通信地址：
        </div>
      </el-footer>
    </el-container>
  </div>
</template>
<script>
export default {
  data() {
    return {
      isLogin: false,
      user: localStorage.getItem("user")?JSON.parse(localStorage.getItem("user")):{
        avatarUrl: "../assets/avatar.png",
      },
      input: "",
    };
  },
  methods: {
    //回到主页
    toHome() {
      this.$router.push("/home");
    },
    //处理下拉菜单的方法
    handleCommand(command) {
      if (command == "toCenter") {
        //“更多信息”点击事件：跳转到个人中心页
        this.$router.push("/center");
      }
      if (command == "logout") {
       // this.$store.commit("setToken", ""); //token设为空字符串
    localStorage.removeItem("user")
        this.$router.push("/");
        this.$message({
          message: "已退出登录",
          type: "success",
        });
      }
      if (command == "toPassword") {
        //“修改密码”点击事件：跳转到修改密码页面
        this.$router.push("/password");
      }
    },
    //搜索
    search() {
      this.$router.push({
        path: "/search",
        query: {
          input: this.input,
        },
      });
    },
    //添加商品按钮
    addGoodsBtn() {
      this.$router.push("/addGoods");
    },
    myPurchaseBtn() {
      this.$router.push("/myPurchase");
    },
    //我的收藏按钮
    bookmarkBtn() {
      this.$router.push("/bookmark");
    },
    //我的卖出按钮
    mySellBtn() {
      this.$router.push("/mySell");
    },
    //----footer-----
    //跳转管理员页面
    toAdmin() {
      let superuser = this.$store.getters.getSuperuser;
      if (superuser == 1) {
        this.$router.push("/admin");
        this.$message({
          type: "success",
          message: "欢迎来到管理员页面",
        });
      } else {
        this.$message.error("请使用管理员账号登录");
      }
    },
  },
  created() {
    this.user.uid = localStorage.getItem("userId");
   /* this.$axios.get("/user/findUserInfo/" + this.user.uid).then((res) => {
      this.user = res.data.data;
      this.isLogin = true;
    });*/
  },
};
</script>
<style scoped>
.logo span {
  cursor: pointer;
}
.el-input >>> .el-input__inner {
  /* background-color: rgba(255, 255, 255, 0.4); */
  border: 0;
}
el-input {
  outline: none;
}
.el-header {
  padding: 0;
  display: flex;
  background-color: var(--primary-color);
}
.el-header .logo {
  flex: 1;
  color: #fff;
  line-height: 60px;
  font-size: 24px;
  letter-spacing: 1px;
  user-select: none;
  margin-left: 10px;
  font-family: "Yuanti SC", Youyuan, "You Yuan", 幼圆, "PingFang SC",
    "Microsoft Yahei", Helvetica, sans-serif;
}
.el-header .search {
  flex: 1;
  display: flex;
  align-items: center;
}
.el-header .user-info {
  flex: 1;
  display: flex;
  justify-content: flex-end;
}
.el-header .user-info .bookmark {
  width: 240px;
  line-height: 60px;
  text-align: center;
  color: #fff;
  font-weight: 500;
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
}
.el-header .user-info .avatar {
  margin: 10px 24px 10px 0;
  width: 40px;
  height: 40px;
  border-radius: 20px;
  background-color: rgb(185, 185, 185);
  cursor: pointer;
  overflow: hidden;
}
.el-header .user-info .avatar img {
  width: 100%;
}
.el-footer {
  background-color: var(--primary-color);
  color: #fff;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  line-height: 200%;
}
.link {
  display: flex;
  justify-content: center;
  font-size: small;
}
.link div {
  cursor: pointer;
}
.link div:hover {
  color: #f1c40f;
}
</style>

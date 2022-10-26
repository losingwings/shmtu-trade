<template>
  <div class="login">
    <div class="index">
      <div class="picture hidden-sm-and-down">
        <div class="title">海大自然回收站</div>

      </div>
      <div class="menu">
        <div class="title-small hidden-md-and-up">校园二手交易平台</div>
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>{{ isRegisterBtnClick == false ? "登录" : "注册" }}</span>
            <el-button
                @click="registerBtn()"
                style="float: right; padding: 3px 0"
                type="text"
            >{{
                isRegisterBtnClick == false ? "注册" : "返回登录"
              }}</el-button>
          </div>
          <!-- 登录面板 -->
          <el-form
              ref="user"
              :model="user"
              label-width="60px"
              v-if="isRegisterBtnClick == false"
          >
            <el-form-item label="用户名" prop="username">
              <el-input
                  autocomplete="off"
                  prefix-icon="el-icon-user"
                  v-model="user.username"
                  placeholder="请输入用户名"
              ></el-input>
            </el-form-item>
            <el-form-item label="密码" prop="password">
              <el-input
                  autocomplete="off"
                  prefix-icon="el-icon-lock"
                  v-model="user.password"
                  placeholder="请输入密码"
                  type="admin_pwd"
                  show-password
              ></el-input>
            </el-form-item>
            <el-form-item label="验证码" prop="validCode">
              <div style="display: flex">
                  <el-input  prefix-icon="el-icon-key" v-model="user.validCode" placeholder="请输入验证码"></el-input>
                  <ValidCode @input="createValidCode"/>
              </div>

            </el-form-item>

            <!-- 操作按钮 -->
            <div class="option">
              <el-button type="primary" style="width: 120px" @click="login()">登录</el-button>
              <!-- 待开启功能：忘记密码 -->
              <!-- <router-link to="/lostPwd">忘记密码</router-link> -->
            </div>
          </el-form>
          <!-- 注册面板 -->
          <el-form
              :model="user"
              label-width="60px"
              v-if="isRegisterBtnClick == true">

            <el-form-item label="用户名">
              <el-input
                  v-model="newUser.username"
                  placeholder="请输入用户名"
              ></el-input>
            </el-form-item>
            <el-form-item label="密码">
              <el-input
                  v-model="newUser.password"
                  placeholder="请输入密码"
                  type="admin_pwd"
                  show-password
              ></el-input>
            </el-form-item>
            <el-form-item label="确认">
              <el-input
                  v-model="newUser.confirmPwd"
                  placeholder="请再次输入密码"
                  type="admin_pwd"
                  show-password
              ></el-input>
            </el-form-item>

            <div class="option">
              <el-button type="primary" style="width: 120px" @click="register()">注册</el-button></div>
          </el-form>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";
import ValidCode from "@/components/ValidCode";

export default {
  name:"Login",
  components:{
    ValidCode
  },
  data() {
    return {
      isRegisterBtnClick: false, //注册按钮是否被点击（是否切换到注册面板）
      user: localStorage.getItem("user")?JSON.parse(localStorage.getItem("user")): {
        userName: "",
        password: "",
      },
      newUser: {
        userName: "",
        password: "",
        confirmPwd: "",
      },
      validCode:''
      // 加背景图片
      // bg: {
      //   backgroundImage: "url(" + require("@/assets/bg.jpg") + ")",
      //   backgroundRepeat: "no-repeat",
      //   backgroundSize: "100% 100%"
      //
    };
  },
  methods: {
    // 接收验证码组件提交的 4位验证码
    createValidCode(data) {
      this.validCode = data
    },
    //登录功能
    login() {
      this.$refs['user'].validate((valid) => {
        if (valid) {
          this.request.post("/user/login", this.user).then((res) => {
                if (!this.user.validCode) {
                  this.$message.error("请填写验证码")
                  return
                }
                if (this.user.validCode.toLowerCase() !== this.validCode.toLowerCase()) {
                  this.$message.error("验证码错误")
                  return
                }
                if (res.code === "200") {
                  //200代表登陆成功
                  localStorage.setItem("user", JSON.stringify(res.data));//存储用户信息到浏览器
                  this.$router.push('/home')
                  this.$message({
                    type: "success",
                    message: "欢迎来到校园二手交易平台",
                  });
                } else {
                  this.$message.error(res.msg);
                }
              })
              .catch(() => {
                this.$message.error("服务器繁忙，请稍后再试");
              })
        }
      });

    },
    //点击注册按钮事件（切换到注册）
    registerBtn() {
      this.isRegisterBtnClick = !this.isRegisterBtnClick;
    },
    //注册功能
    register() {
      if (this.newUser.password == this.newUser.confirmPwd) {
        this.request
            .post("/user/register", this.newUser)
            .then((res) => {
          if (res.code === "200") {
            //后端返回状态码200意为成功
            this.$message({
              message: "注册成功",
              type: "success",
            });
            this.registerBtn(); //调用方法转到登录面板
            //帮助用户填好登录信息
            this.user.userName = this.newUser.userName;
            this.user.password = this.newUser.password;
          } else {
            //注册失败
            this.$message.error("注册失败，用户名已存在");
          }
        });
      } else {
        this.$message.error("两次输入的密码不一致！");
      }
    },
/*    sendMs(){
      this.$axios.get("/sendMs/"+this.newUser.tel).then((res)=>{
        console.log(res);
      })
    }*/
  },
  // created() {
  //   console.log("登录页token值：", localStorage.getItem("token"));
  // },
};
</script>

<style scoped>
.login {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.index {
  width: 1000px;
  height: 500px;
  display: flex;
  justify-content: center;
}
.picture {
  width: calc(100% - 400px);
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.title {
  text-align: center;
  font-size: 36px;
  user-select: none;
  letter-spacing: 2px;
}
.title-small {
  text-align: center;
  font-size: 30px;
  user-select: none;
  letter-spacing: 2px;
  margin: 10px 0;
}
.picture img {
  height: 80%;
}
.menu {
  width: 400px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
/* 卡片 */
.el-card {
  width: 60px;
}
.text {
  font-size: 14px;
}
.item {
  margin-bottom: 18px;
}
.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both;
}
.box-card {
  width: 100%;
}
/* ---结束卡片---- */
.option {
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  font-size: small;
}
.verifyCode {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.verifyCode .el-input {
  width: 180px;
}
.sendCode {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.sendCode .el-input {
  width: 180px;
}
</style>

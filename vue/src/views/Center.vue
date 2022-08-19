<template>
  <div class="center">
    <el-page-header @back="goBack" content="个人信息"> </el-page-header>
    <!-- header -->
    <div class="header">
      <div class="avatar header-item">
        <img :src="user.avatar" alt="" />
      </div>
      <div class="username header-item">
        {{ user.username }}
      </div>
      <div class="money header-item">余额：￥{{ user.money }}</div>
    </div>
    <!-- 修改头像 -->
    <div class="index" style="padding-left: 30px">
      <!-- 充值 -->
      <div class="recharge">
        <el-input v-model="recharge" @keyup.enter.native="rechargeBtn"></el-input>
        <el-button type="primary" @click="rechargeBtn">充值</el-button>
      </div>
      <form>
        <input type="file" name="file" @change="getFile($event)" />
        <button
          class="button button-primary button-pill button-small"
          @click="submit($event)"
        >
          修改头像
        </button>
      </form>
    </div>
    <!-- index form -->
    <div class="index">
      <el-form :inline="true" :model="user" label-width="80px">
        <el-form-item label="手机">
          <el-input placeholder="请输入手机号码" v-model="user.tel"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-input placeholder="请输入性别" v-model="user.sex"></el-input>
        </el-form-item>
        <el-form-item label="地址">
          <el-input placeholder="请输入地址" v-model="user.location"></el-input>
        </el-form-item>
      </el-form>
      <div class="option">
        <el-button type="primary" style="width: 120px" @click="update"
          >确认修改</el-button
        >
      </div>
    </div>
    <!-- 修改密码模块 -->
    <div class="index">
      <el-form :inline="true" :model="user" label-width="80px">
        <el-form-item label="旧密码">
          <el-input
            type="password"
            show-password
            placeholder="请输入旧密码"
            v-model="updatePwd.oldPwd"
          ></el-input>
        </el-form-item>
        <el-form-item label="新密码">
          <el-input
            type="password"
            show-password
            placeholder="请输入新密码"
            v-model="updatePwd.newPwd"
          ></el-input>
        </el-form-item>
        <el-form-item label="确认密码">
          <el-input
            type="password"
            show-password
            placeholder="请再次输入密码"
            v-model="confirmPwd"
          ></el-input>
        </el-form-item>
        <div class="option">
          <el-button type="primary" style="width: 120px" @click="updatePwdBtn"
            >修改密码</el-button
          >
        </div>
      </el-form>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      recharge: 0, //充值
      user: {
        avatar: "",
        uid: null,
        username: "",
        sex: "",
        money: 0,
        location: "",
        tel: "",
      },
      updatePwd: {
        uid: null,
        oldPwd: "",
        newPwd: "",
      },
      confirmPwd: "",
    };
  },
  methods: {
    goBack() {
      this.$router.push("/allGoods");
    },
    getFile: function (event) {
      this.file = event.target.files[0];
      console.log("getFile", this.file);
    },
    rechargeBtn() {
      console.log("充值金额", this.recharge);
      this.$axios
        .post(
          "/user/Recharge/" +
            this.$store.getters.getUserId +
            "/" +
            this.recharge
        )
        .then((res) => {
          this.reload();
          console.log("充值结果", res);
        });
    },
    submit: function (event) {
      let that = this;
      //阻止元素发生默认的行为
      event.preventDefault();
      let formData = new FormData();
      formData.append("file", this.file);
      formData.append("username", this.user.username);
      this.$axios
        .post("/user/upload", formData)
        .then(function (response) {
          //--------------⭐主要-----------------------
          console.log("success", response.data.data);

          that.user.avatar = response.data.data;
          console.log("获取到了图片链接", that.user.avatar);
        })
        .catch(function (error) {
          console.log("error", error);
        });
    },
    update() {
      console.log("获取到了user信息", this.user);
      this.$axios.post("/user/updateUserInfo", this.user).then((res) => {
        console.log("更新成功了吗？", res);
        this.$message({
          message: "修改成功",
          type: "success",
        });
      });
    },
    updatePwdBtn() {
      this.updatePwd.uid = this.user.uid;
      console.log(this.updatePwd);
      this.$axios
        .post("/user/updateUserPassword", this.updatePwd)
        .then((res) => {
          console.log(res);
          if (res.data.state == 201) {
            this.$message.error("修改密码失败，原密码不正确");
          } else {
            (this.updatePwd.oldPwd = ""),
              (this.updatePwd.newPwd = ""),
              (this.confirmPwd = "");
            this.$message({
              message: "修改成功",
              type: "success",
            });
          }
        });
    },
  },
  created() {
    let uid = localStorage.getItem("userId");
    this.$axios.get("/user/findUserInfo/" + uid).then((res) => {
      this.user.avatar = res.data.data.avatar;
      this.user.uid = res.data.data.uid;
      this.user.username = res.data.data.username;
      this.user.sex = res.data.data.sex;
      this.user.location = res.data.data.location;
      this.user.tel = res.data.data.tel;
      this.user.money = res.data.data.money;
      console.log("this.user", this.user);
    });
  },
  inject: ["reload"],
};
</script>
<style scoped>
.center {
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  height: 100vh;
  background-color: #fff;
}
.header {
  width: 92%;
  display: flex;
  margin: 20px auto;
}
.header-item {
  margin: 0 2%;
  display: flex;
  align-items: center;
}
.header .avatar {
  background-color: rgb(187, 187, 187);
  width: 80px;
  height: 80px;
  border-radius: 40px;
  overflow: hidden;
}
.header .avatar img {
  width: 100%;
}
.header .username {
  font-weight: 600;
  font-size: 28px;
  letter-spacing: 2px;
}
.header .money {
  color: #27ae60;
}
.index {
  width: 92%;
  margin: 50px auto;
}
.index .option {
  display: flex;
  justify-content: center;
}
.index .recharge {
  margin-bottom: 20px;
  display: flex;
}
.index .recharge .el-input {
  width: 140px;
  margin-right: 20px;
}
</style>
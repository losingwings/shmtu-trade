<template>
  <div class="center">
    <el-page-header @back="goBack" content="个人信息"> </el-page-header>
    <div class="header">
      <div class="avatar header-item">
        <div>
          <el-upload
              :style="styleChange()"
              class="avatar-uploader"
              action="http://localhost:9090/file/upload"
              :show-file-list="false"
              :disabled="!boolean"
              :on-success="handleAvatarSuccess"
          >
            <img v-if="form.avatarUrl" :src="form.avatarUrl" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </div>
      </div>
    </div>
    <div class="body">
      <div class="body-item">
        <span>用户帐号：</span>
        <el-input v-model="form.username" disabled>
        </el-input>
      </div>
      <div class="body-item">
        <span>用户昵称：</span>
        <el-input
            placeholder="请输入用户昵称"
            v-model="form.nickname"
            :disabled="!boolean"
        >
        </el-input>
      </div>
      <div class="body-item">
        <span>手机号码：</span>
        <el-input
            placeholder="请输入手机号码"
            v-model="form.phone"
            :disabled="!boolean"
        >
        </el-input>
      </div>
      <div class="body-item">
        <span>邮箱地址：</span>
        <el-input
            placeholder="请输入邮箱地址"
            v-model="form.email"
            :disabled="!boolean"
        >
        </el-input>
      </div>
      <div class="body-item">
        <span>注册时间：</span>
        <el-input placeholder="请输入内容" v-model="form.createTime" disabled>
        </el-input>
      </div>
      <div class="body-item" style="display: flex" >
        <el-button type="primary" @click="isEdit()">{{ boolean ? "返回" : "编辑" }}</el-button>
        <el-button @click="save()" v-show="boolean">提交</el-button>
      </div>
    </div>
  </div>
</template>
<script>
import {serverIp} from "../../public/config";
export default {
  name: "Center",
  data() {
    return {
      formLabelWidth: "120px",
      form2:{},
      form: {},
      serverIp: serverIp,
      dialogFormVisible: false,
      dialogFormVisible2: false,
      user:localStorage.getItem("user")?JSON.parse(localStorage.getItem("user")):{},
      boolean: false,
    };
  },
  created() {
      this.load()
    this.getUser().then(res => {
      console.log(res)
      this.form = res
    })
  },
  methods: {
   styleChange() {
      return this.form.avatarUrl ? "" : "padding:75px";
    },
    async getUser() {
      return (await this.request.get("/user/username/" + this.user.username)).data
    },
    load(){
      const username= this.user.username;
      if(!username){
        this.$message.error("当前无法获取用户信息")
        return
      }
      this.request.get("/user/username/" + username).then(res => {
        this.form=res.data
      });
    },
    save() {
      this.request.post("/user", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("修改成功")
          this.dialogFormVisible =false
          this.load()
          this.isEdit()
          // 触发父级更新User的方法
          this.$emit("refreshUser")
          // 更新浏览器存储的用户信息
          this.getUser().then(res => {
            res.token = JSON.parse(localStorage.getItem("user")).token
            localStorage.setItem("user", JSON.stringify(res))
          })
        } else {
          this.$message.error("修改失败")
        }
      })
    },
    handleAvatarSuccess(res) {
      this.form.avatarUrl = res
    },

    goBack() {
      this.$router.push("/allGoods");
    },

    isEdit() {
      this.boolean = !this.boolean;
    },
  },
};
</script>

<style scoped>
.center {
  /* background: url("~@/assets/bg2.png");  */
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  height: 1000px;
  background-color: #fff;
}
.header {
  width: 1200px  ;
  height: 200px  ;
  display: flex;
  margin: 20px auto;
  justify-content: center;
  align-items: center;
  background-color: purple;
}
.body {
  width: 1200px  ;
  height: 200px;
  /* background-color: red; */
  display: flex;
  flex-direction: column;
}
.header-item {
  margin: 0 2%;

  align-items: center;
  justify-content: center;
}
.body-item {
  margin: 10px auto 10px 400px;
  /* display: flex;
  justify-content: center; */
}
.header .avatar {
  background-color: rgb(187, 187, 187);
  width: 200px;
  height: 200px;
  border-radius: 100px;
  overflow: hidden;
}
.header .avatar img {
  width: 100%;
}

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 50px;
  height: 50px;
  line-height: 50px;
  text-align: center;
}
.avatar {
  border-radius: 100px;
  width: 200px;
  height: 200px;
  display: block;
}
</style>
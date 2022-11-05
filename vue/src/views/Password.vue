<template>
 <div class="center">
   <el-page-header @back="goBack" content="修改密码"> </el-page-header>
    <el-form :model="form" :rules="rules" ref="pass">
      <el-form-item label="原密码"  prop="password">
        <el-input size="medium" type="password" v-model="form.password" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="新密码"  prop="newPassword">
        <el-input size="medium" show-password type="password" v-model="form.newPassword" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="确认新密码"  prop="confirmPassword">
        <el-input size="medium" show-password type="password" v-model="form.confirmPassword" auto-complete="off"></el-input>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer" align="center">
      <el-button  type="primary" @click="save" round>确认修改</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: "Password",
  data() {
    return {
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      rules: {
        password: [
          { required: true, message: '请输入原密码', trigger: 'blur' },
          { min: 3, message: '长度不少于3位', trigger: 'blur' }
        ],
        newPassword: [
          { required: true, message: '请输入新密码', trigger: 'blur' },
          { min: 3, message: '长度不少于3位', trigger: 'blur' }
        ],
        confirmPassword: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 3, message: '长度不少于3位', trigger: 'blur' }
        ],
      }
    }
  },
  created() {
    this.form.username = this.user.username
  },
  methods: {
    save() {
      this.$refs.pass.validate((valid) => {
        if (valid) {
          if (this.form.newPassword !== this.form.confirmPassword) {
            this.$message.error("2次输入的新密码不相同")
            return false
          }
          this.request.post("/user/password", this.form).then(res => {
            if (res.code === '200') {
              this.$message.success("修改成功")
              this.form={}
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
    goBack() {
      this.$router.push("/allGoods");
    },
  }
}
</script>

<style scoped>
.center {
  /* background: url("~@/assets/bg2.png");  */
  margin: 0 auto;
  padding: 12px 12px;
  width: 600px;
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
<template>
  <div class="add-user">
    <el-form
      :model="user"
      :rules="rules"
      ref="user"
      label-width="100px"
      class="demo-ruleForm"
    >
      <el-form-item label="用户名" prop="username">
        <el-input v-model="user.username"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="user.password"></el-input>
      </el-form-item>
      <el-form-item label="性别">
        <el-radio-group v-model="user.sex">
          <el-radio label="男"></el-radio>
          <el-radio label="女"></el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="余额" prop="money">
        <el-input v-model="user.money"></el-input>
      </el-form-item>
      <el-form-item label="地址" prop="location">
        <el-input v-model="user.location"></el-input>
      </el-form-item>
      <el-form-item label="手机" prop="tel">
        <el-input v-model="user.tel"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('user')">添加</el-button>
        <el-button @click="resetForm('user')">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
export default {
  data() {
    return {
      user: {
        avatar: "",
        username: "",
        password: "",
        sex: "",
        money: 0,
        location: "",
        tel: "",
        status: 1,
      },
      rules: {
        username: [
          {
            required: true,
            message: "请输入员工姓名",
            trigger: "blur",
          },
          {
            min: 1,
            max: 10,
            message: "长度在 1 到 10 个字符",
            trigger: "blur",
          },
        ],
        location: [
          {
            required: true,
            message: "请输入地址信息",
            trigger: "blur",
          },
          {
            min: 3,
            max: 30,
            message: "字数在10到30之间",
            trigger: "blur",
          },
        ],
        tel: [
          {
            required: true,
            message: "请输入手机",
            trigger: "blur",
          },
          {
            min: 1,
            max: 16,
            message: "长度在 1 到 16 个字符",
            trigger: "blur",
          },
        ],
      },
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          console.log("添加", this.user);
          this.$axios
            .post("/admin/addUser", this.user)
            .then((res) => {
              this.$router.push("/findAllUser");
              this.$message({
                message: "修改成功",
                type: "success",
              });
              console.log("res:", res);
            })
            .catch((err) => {
              console.log(err);
            });
        } else {
          this.$message.error("修改失败");
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
  },
};
</script>
<style scoped>
.add-user {
  padding-top: 20px;
  padding-right: 36px;
}
</style>
<template>
  <div>
    <el-form
      :model="user"
      :rules="rules"
      ref="user"
      label-width="100px"
      class="demo-ruleForm"
    >
      <el-form-item label="用户编号" prop="uid">
        <el-input v-model="user.uid" readonly></el-input>
      </el-form-item>
      <el-form-item label="用户名" prop="username">
        <el-input v-model="user.username"></el-input>
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
        <el-button type="primary" @click="submitForm('user')">修改</el-button>
        <el-button @click="resetForm('user')">重置</el-button>
        <el-button @click="goBack">返回</el-button>
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
        uid: 0,
        username: "",
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
    goBack() {
      this.$router.push("/findAllUser");
    },
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          console.log("发起修改", this.user);
          this.$axios
            .post("/admin/updateUserMessage", this.user)
            .then((res) => {
              this.$router.push("/findAllUser");
              this.$message({
                message: "修改成功",
                type: "success",
              });
              console.log("res:", res);
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
  created() {
    console.log("uid", this.$route.query.uid);
    this.$axios
      .get("/admin/findUserInfoById/" + this.$route.query.uid)
      .then((res) => {
        console.log(res.data.data);
        this.user = res.data.data;
      });
  },
};
</script>
<template>
  <div>
    <el-form
      :model="goods"
      :rules="rules"
      ref="goods"
      label-width="100px"
      class="demo-ruleForm"
    >
      <el-form-item label="商品编号" prop="gid">
        <el-input v-model="goods.gid" readonly></el-input>
      </el-form-item>
      <el-form-item label="商品名称" prop="gname">
        <el-input v-model="goods.gname"></el-input>
      </el-form-item>
      <el-form-item label="发布者编号" prop="uid">
        <el-input v-model="goods.gid" readonly></el-input>
      </el-form-item>
      <el-form-item label="所属类别" prop="cid">
        <el-input v-model="goods.cid"></el-input>
      </el-form-item>
      <el-form-item label="价格" prop="price">
        <el-input v-model="goods.price"></el-input>
      </el-form-item>
      <el-form-item label="详情" prop="remark">
        <el-input v-model="goods.remark"></el-input>
      </el-form-item>
      <el-form-item label="发布时间" prop="time">
        <el-input v-model="goods.time" readonly></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('goods')">修改</el-button>
        <el-button @click="resetForm('goods')">重置</el-button>
        <el-button @click="goBack">返回</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
export default {
  data() {
    return {
      goods: {},
      rules: {
        gname: [
          {
            required: true,
            message: "请输入商品名称",
            trigger: "blur",
          },
          {
            min: 1,
            max: 12,
            message: "长度在 1 到 12 个字符",
            trigger: "blur",
          },
        ],
        remark: [
          {
            required: true,
            message: "请输入详情描述",
            trigger: "blur",
          },
          {
            min: 0,
            max: 40,
            message: "字数在0到40之间",
            trigger: "blur",
          },
        ],
      },
    };
  },
  methods: {
    goBack() {
      this.$router.push("/findAllGoods");
    },
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          console.log("发起修改", this.goods);
          this.$axios.post("/admin/updateGoodsInfo", this.goods).then((res) => {
            this.$router.push("/findAllGoods");
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
    this.$axios
      .get("/admin/findGoodsInfoById/" + this.$route.query.gid)
      .then((res) => {
        this.goods = res.data.data;
      });
  },
};
</script>
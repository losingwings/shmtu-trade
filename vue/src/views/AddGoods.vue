<template>
  <div class="add-goods">
    <el-page-header @back="goBack" content="发布商品"> </el-page-header>
    <div class="add-pic">
      <form>
        <input type="file" name="file" @change="getFile($event)" />
        <button
          class="button button-primary button-pill button-small"
          @click="submit($event)"
        >
          提交
        </button>
      </form>
    </div>
    <div class="index">
      <div class="form">
        <el-form :inline="true" label-width="80px">
          <el-form-item label="商品分类">
            <el-radio-group v-model="catalog">
              <el-radio label="数码/办公"></el-radio>
              <el-radio label="运动/户外"></el-radio>
              <el-radio label="书籍/学习"></el-radio>
              <el-radio label="乐器/美术"></el-radio>
              <el-radio label="游戏/模型"></el-radio>
              <el-radio label="生活/家居"></el-radio>
              <el-radio label="文具/箱包"></el-radio>
              <el-radio label="服装/饰品"></el-radio>
              <el-radio label="美妆/清洁"></el-radio>
              <el-radio label="食品/零食"></el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="商品名称">
            <el-input
              placeholder="请输入商品名称"
              v-model="good.gname"
            ></el-input>
          </el-form-item>
          <el-form-item label="描述">
            <el-input placeholder="请输入描述" v-model="good.remark"></el-input>
          </el-form-item>
          <el-form-item label="价格">
            <el-input placeholder="请输入价格" v-model="good.price"></el-input>
          </el-form-item>
        </el-form>
        <div class="option">
          <el-button type="primary" style="width: 120px" @click="confirmSubmit"
            >确认发布</el-button
          >
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      catalog: "",
      file: "",
      username: "xmx",
      pic: "",
      good: {
        gid: null,
        uid: null,
        gname: "",
        price: null,
        pic: "",
        status: 1,
        remark: "",
        cid: null,
      },
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
    submit: function (event) {
      let that = this;
      //阻止元素发生默认的行为
      event.preventDefault();
      let formData = new FormData();
      formData.append("file", this.file);
      this.$axios
        .post("/upload/good", formData)
        .then(function (response) {
          that.good.pic = response.data.data;
          console.log("获取到了图片链接", that.good.pic);
          that.$message({
            message: "上传成功",
            type: "success",
          });
        })
    },
    showUserInfo() {
      console.log("showUserInfo():", this.user);
    },
    getCid(select) {
      if (select == "数码/办公") {
        return 1;
      } else if (select == "运动/户外") {
        return 2;
      } else if (select == "书籍/学习") {
        return 3;
      } else if (select == "乐器/美术") {
        return 4;
      } else if (select == "游戏/模型") {
        return 5;
      } else if (select == "生活/家居") {
        return 6;
      } else if (select == "文具/箱包") {
        return 7;
      } else if (select == "服装/饰品") {
        return 8;
      } else if (select == "美妆/清洁") {
        return 9;
      } else {
        return 10;
      }
    },
    confirmSubmit() {
      // console.log("confirmSubmit",this.good,this.catalog);
      let select = this.catalog;
      this.good.cid = this.getCid(select);
      console.log("商品准备发布：this.good:", this.good);
      this.$axios.post("/goods/addGood", this.good).then((res) => {
        console.log("发布成功", res);
        this.$message({
          message: "上传成功",
          type: "success",
        });
      });
    },
  },
  created() {
    this.good.uid = localStorage.getItem("userId");
  },
};
</script>
<style scoped>
.add-goods {
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  height: 800px;
  background-color: #fff;
}
.index {
  display: flex;
}
.index .imgBox {
  width: 200px;
}
.index .imgBox img {
  width: 100%;
}
.index .form {
  margin-top: 30px;
  margin-left: 30px;
  width: 800px;
  height: 600px;
}
.index .option {
  display: flex;
  justify-content: center;
}
.add-pic {
  width: 400px;
  margin: 10px auto;
}
.index {
  width: 800px;
  margin: 10px auto;
}
</style>
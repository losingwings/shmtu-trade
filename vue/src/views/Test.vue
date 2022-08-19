<template>
  <div>
    <div class="testTime">
      <h1>测试时间</h1>
      <el-date-picker
        v-model="value1"
        type="datetime"
        placeholder="选择日期时间"
      >
      </el-date-picker>
      <el-button type="primary" @click="formate">格式化</el-button>
      <p>原时间：{{ value1 }}</p>
      <p>格式化：{{ value2 }}</p>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      value1: "",
      value2: "",
      user: {
        name: "小明",
        password: "123"
      }
    };
  },
  methods: {
    formate() {
      var moment = require("moment");
      this.value2 = moment(this.value1).format("YYYY-MM-DD HH:mm:SS");
    },
  },
};
</script>
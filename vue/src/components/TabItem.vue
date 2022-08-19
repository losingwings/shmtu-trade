<template>
  <div class="tab-item">
    <div class="order-in-progress" v-for="item in order">
      <div class="order-item">
        <div class="img-box">
          <img :src="item.pic" alt="" />
        </div>
        <div class="desc">
          <p>订单编号：{{ item.oid }}</p>
          <p>商品名称：{{ item.gname }}</p>
          <p>价格：￥{{ item.price }}</p>
          <p>配送方式：{{ item.bySelf == 0 ? "配送" : "自取" }}</p>
        </div>
        <!-- pay 待支付 显示：支付按钮、取消按钮 -->
        <div class="option" v-if="tabItemType == 'pay'">
          <el-button
            type="primary"
            @click="toPay(item)"
            v-loading.fullscreen.lock="fullscreenLoading"
            >立即支付</el-button
          >
          <el-button type="warning" @click="cancelOrderBtn(item)"
            >取消订单</el-button
          >
        </div>
        <div class="option" v-else-if="tabItemType == 'send'">
          <p style="font-size: larger; color: #f39c12">等待商家发货</p>
        </div>
        <!-- sign 待签收 显示：确认收货按钮-->
        <div class="option" v-else-if="tabItemType == 'sign'">
          <el-button type="primary" @click="confirm(item)">确认收货</el-button>
          <el-button type="warning" @click="rejectBtn(item)">退款</el-button>
        </div>
        <!-- toSend 待发货 -->
        <div class="toSend" v-else-if="tabItemType == 'toSend'">
          <el-button type="primary" @click="toSendBtn(item)">去发货</el-button>
        </div>
        <!-- 待退款 -->
        <div class="reject" v-else-if="tabItemType == 'reject'">
          <el-button type="primary" @click="rejectBtn(item)"
            >同意退款</el-button
          >
        </div>
        <!-- 其他 空白占位置 -->
        <div class="option" v-else></div>
      </div>
      <el-divider></el-divider>
    </div>
  </div>
</template>
<script>
export default {
  props: ["order", "tabItemType"], //tabItemType: pay：待支付；sign：待签收；normal：没有按钮
  data() {
    return {
      fullscreenLoading: false, //全屏加载
    };
  },
  methods: {
    toPay(item) {
      //付款按钮
      this.fullscreenLoading = true;
      setTimeout(() => {
        this.fullscreenLoading = false;
        this.$router.push({
          path: "/rePay",
          query: {
            gid: item.goodId,
          },
        });
      }, 1000);
    },
    toSendBtn(item) {
      this.$axios.post("/order/confirmSendOrder/" + item.oid).then((res) => {
        console.log("发货", res);
        this.reload();
        this.$message({
          type: "success",
          message: "发货成功",
        });
      });
    },
    cancelOrderBtn(item) {
      this.$axios.post("/order/cancelOrder/" + item.oid).then((res) => {
        this.reload();
        this.$message("已取消订单");
      });
    },
    rejectBtn(item) {
      this.$axios.post("/order/requestGoodRejected/" + item.oid).then((res) => {
        console.log("退款", res);
        this.reload();
        this.$message({
          message: "已申请退款",
          type: "success",
        });
      });
    },
    rejectBtn(item) {
      this.$axios.post("/order/agreeGoodRejected/" + item.oid).then((res) => {
        console.log("同意退款", res);
        this.reload();
        this.$message({
          message: "已同意退款",
          type: "success",
        });
      });
    },
    confirm(item) {
      console.log(item.oid);
      this.$axios.post("/order/confirmReceipt/" + item.oid).then((res) => {
        console.log("确认收货", res);
        this.reload();
        this.$message({
          message: "已确认收货",
          type: "success",
        });
      });
    },
  },
  inject: ["reload"],
};
</script>
<style scoped>
.order-item {
  height: 160px;
  display: flex;
  justify-content: space-evenly;
  align-items: center;
}
.img-box {
  width: 140px;
  height: 140px;
  background-color: rgb(114, 114, 114);
  overflow: hidden;
}
.img-box img {
  width: 100%;
}
.desc {
  width: 500px;
  height: 160px;
}
.option {
  width: 300px;
  display: flex;
  justify-content: center;
}
</style>
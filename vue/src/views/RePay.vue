<template>
  <div class="to-pay">
    <div class="center">
      <el-page-header @back="goBack" content="确认订单"></el-page-header>
      <div class="flex-index">
        <div class="order-msg" v-if="isShowError == true">
          {{ orderMsg }}
        </div>
        <el-card class="box-card" v-else>
          <div slot="header" class="clearfix">
            <span>订单详情</span>
          </div>
          <!-- 1、商品详情 -->
          <div class="goods-detail">
            <div class="img-box">
              <img :src="order.goods.pic" alt="" />
            </div>
            <div class="desc">
              <h2>{{ order.goods.gname }}</h2>
              <p>{{ order.goods.remark }}</p>
              <h2 style="color: #16a085">￥{{ order.goods.price }}</h2>
            </div>
          </div>
          <!-- 2、配送方式 -->
          <el-tabs type="card" v-model="selectSend">
            <!-- 2.1、选择自提 -->
            <el-tab-pane label="自提">
              <div class="tip">请获知卖家信息并填写自提时间</div>
              <el-form :model="order" label-width="80px">
                <el-form-item label="自提地点">
                  <el-input
                    v-model="order.buyerDto.location"
                    readonly
                  ></el-input>
                </el-form-item>
                <el-form-item label="自提时间">
                  <el-date-picker
                    v-model="order.time"
                    type="datetime"
                    placeholder="选择自提时间"
                    default-time="12:00:00"
                  >
                  </el-date-picker>
                </el-form-item>
                <el-form-item label="卖家姓名">
                  <el-input
                    v-model="order.sellerDto.sellerName"
                    readonly
                  ></el-input>
                </el-form-item>
                <el-form-item label="联系电话">
                  <el-input v-model="order.sellerDto.tel" readonly></el-input>
                </el-form-item>
              </el-form>
            </el-tab-pane>
            <!-- 2.2、选择配送 -->
            <el-tab-pane label="配送">
              <div class="tip">请核对收货信息并填写发货时间</div>
              <el-form :model="order" label-width="80px">
                <el-form-item label="我的地址">
                  <el-input
                    v-model="order.buyerDto.location"
                    readonly
                  ></el-input>
                </el-form-item>
                <el-form-item label="配送时间">
                  <el-date-picker
                    v-model="order.time"
                    type="datetime"
                    placeholder="选择配送时间"
                    default-time="12:00:00"
                  >
                  </el-date-picker>
                </el-form-item>
                <el-form-item label="我的姓名">
                  <el-input
                    v-model="order.buyerDto.buyerName"
                    readonly
                  ></el-input>
                </el-form-item>
                <el-form-item label="我的手机">
                  <el-input v-model="order.sellerDto.tel" readonly></el-input>
                </el-form-item>
              </el-form>
            </el-tab-pane>
          </el-tabs>
          <!-- 3、按钮操作 -->
          <div class="option">
            <el-button
              type="info"
              icon="el-icon-circle-close"
              @click="cancelOrderBtn"
              >取消订单</el-button
            >
            <el-button
              type="primary"
              icon="el-icon-arrow-right"
              @click="toPayBtn"
              >立即支付</el-button
            >
          </div>
        </el-card>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      isShowError: false, //当购买自己的商品或重复购买时提示错误
      selectSend: "",
      orderMsg: "",
      orderState: 0,
      order: {
        oid: 0,
        send: "",
        time: "",
        goods: {
          cid: 0,
          gid: 0,
          gname: "",
          pic: "",
          price: 0,
          remark: "",
          status: 1,
          time: "",
          uid: "",
          username: "",
        },
        sellerDto: {
          sellerId: 0,
          sellerName: "",
          location: "",
          tel: "",
        },
        buyerDto: {
          buyerId: 0,
          buyerName: "",
          location: "",
          tel: "",
        },
      },
    };
  },
  watch: {
    orderState() {
      this.isShowError = this.orderState == 200 ? false : true;
    },
    selectSend() {
      this.order.send = this.selectSend == "0" ? "自提" : "配送";
    },
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    toPayBtn() {
      //付款按钮
      this.order.time = this.dateFormat(this.order);
      console.log("this.order", this.order);
      this.$axios.post("/order/toPay", this.order).then((res) => {
        console.log("支付结果", res);
        if (res.data.state == 200) {
          this.$router.push("/home");
          this.$message({
            type: "success",
            message: "支付成功",
          });
        } else {
          this.goBack();
          this.$message.error("余额不足");
        }
      });
    },
    cancelOrderBtn() {
      this.$axios.post("/order/cancelOrder/" + this.order.oid).then((res) => {
        console.log("取消订单", res);
        this.goBack();
        this.$message("已取消订单");
      });
    },
    dateFormat(date) {
      //格式化时间
      var moment = require("moment");
      return moment(date).format("YYYY-MM-DD HH:mm:SS");
    },
  },
  created() {
    let buyInfo = {
      userId: this.$store.getters.getUserId,
      goodId: this.$route.query.gid,
    };
    this.$axios.post("/order/showOrder", buyInfo).then((res) => {
      this.orderMsg = res.data.message;
      this.orderState = res.data.state;
      console.log("订单状态：", this.orderState);
      if (res.data.data != null) {
        this.order = res.data.data;
        this.order.send = "自提";
        console.log("订单信息：", this.order);
      }
    });
  },
};
</script>
<style scoped>
.to-pay {
  padding: 12px 12px;
  padding-bottom: 100px;
  height: 900px;
  background-color: #f1f1f1;
}
.center {
  width: 1200px;
  margin: 0 auto;
}
/* 卡片 */
.box-card {
  width: 700px;
  height: 700px;
  /* background-color: rgb(239, 255, 170); */
}
.flex-index {
  padding: 20px 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.bg-img {
  width: 200px;
  height: 200px;
  overflow: hidden;
}
.bg-img img {
  width: 100%;
}
.goods-detail {
  display: flex;
  justify-content: flex-start;
  align-items: center;
  width: 100%;
  margin-bottom: 10px;
}
.goods-detail .img-box {
  width: 160px;
  height: 160px;
  overflow: hidden;
}
.goods-detail .img-box img {
  width: 100%;
}
.goods-detail .desc {
  width: 520px;
  height: 160px;
  margin-left: 20px;
}
/* tab */
.box-card >>> .is-active {
  color: var(--primary-color) !important;
  font-size: larger;
}
.box-card >>> .el-tabs__item:hover {
  color: var(--primary-color) !important;
}
.el-tab-pane {
  padding: 20px 10px 20px 0;
}
/* 操作按钮 */
.option {
  display: flex;
  justify-content: space-between;
  padding: 0 20px;
}
/* 提示 */
.tip {
  color: red;
  font-size: small;
  margin-bottom: 10px;
  padding-left: 8px;
}
</style>
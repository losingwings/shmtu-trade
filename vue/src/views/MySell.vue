<template>
  <div class="my-purchase">
    <el-page-header @back="goBack" content="我的卖出"> </el-page-header>
    <el-tabs
      type="border-card"
      tab-position="left"
      @tab-click="switchTab"
      v-model="activeTab"
    >
      <!-- 已支付 -->
      <el-tab-pane label="已支付" name="findSellCompletedOrder">
        <TabItem
          :order="order"
          tabItemType="toSend"
          v-if="isHasOrder == true"
        ></TabItem>
        <NoResult :msg="msg" v-else></NoResult>
      </el-tab-pane>
      <!-- 待签收 -->
      <el-tab-pane label="待签收" name="findSellOrderToBeSigned">
        <TabItem
          :order="order"
          tabItemType="normal"
          v-if="isHasOrder == true"
        ></TabItem>
        <NoResult :msg="msg" v-else></NoResult>
      </el-tab-pane>
      <!-- 已签收 -->
      <el-tab-pane label="已签收" name="findSellOrderSigned">
        <TabItem
          :order="order"
          tabItemType="normal"
          v-if="isHasOrder == true"
        ></TabItem>
        <NoResult :msg="msg" v-else></NoResult>
      </el-tab-pane>
      <!-- 待退款 -->
      <el-tab-pane label="待退款" name="findSellRefundedOrder">
        <TabItem
          :order="order"
          tabItemType="reject"
          v-if="isHasOrder == true"
        ></TabItem>
        <NoResult :msg="msg" v-else></NoResult>
      </el-tab-pane>
      <!-- 已失效 -->
      <el-tab-pane label="已失效" name="findSellInvalidOrder">
        <TabItem
          :order="order"
          tabItemType="normal"
          v-if="isHasOrder == true"
        ></TabItem>
        <NoResult :msg="msg" v-else></NoResult>
      </el-tab-pane>
      <div class="pagination" v-if="isShowPagination == true">
        <el-pagination
          background
          layout="prev, pager, next"
          :page-size="pageSize"
          :total="total"
          @current-change="page"
        >
        </el-pagination>
      </div>
    </el-tabs>
  </div>
</template>
<script>
import NoResult from "../components/NoResult";
import TabItem from "../components/TabItem";
export default {
  components: { NoResult, TabItem },
  data() {
    return {
      userId: 0, //用户Id
      message: "", //消息提示
      send: "", //配送方式
      order: null, //订单信息
      total: 0, //分页总数
      pageSize: 5, //每页数量
      isShowPagination: false, //是否展示分页
      activeTab: "findSellCompletedOrder", //默认选中的tab
      path: "", //根据tab.name而变化的path，从而发送不同请求
      isHasOrder: false, //是否有订单数据
      msg: "", //没有数据时的信息提示
    };
  },
  methods: {
    goBack() {
      this.$router.push("/allGoods");
    },
    //查询订单
    findOrder(path, userId, pageNum, pageSize) {
      this.$axios
        .get("/order/" + path + "/" + userId + "/" + pageNum + "/" + pageSize)
        .then((res) => {
          console.log("订单请求结果：", res);
          if (res.data.state == 200) {
            let pageInfo = res.data.data;
            this.order = pageInfo.data;
            this.total = pageInfo.totalSize;
            this.isHasOrder = true;
            this.isShowPagination = this.total > 5 ? true : false;
          } else {
            this.order = null;
            this.total = 0;
            this.msg = res.data.message;
            this.isHasOrder = false;
            this.isShowPagination = false;
          }
        });
    },
    //切换分页
    page(currentPage) {
      this.findOrder(this.path, this.userId, currentPage, this.pageSize);
    },
    //切换tab
    switchTab(tab) {
      this.path = tab.name;
      this.findOrder(this.path, this.userId, 1, this.pageSize);
    },
  },
  created() {
    this.userId = this.$store.getters.getUserId;
    this.path = "findSellCompletedOrder";
    this.findOrder(this.path, this.userId, 1, this.pageSize);
  },
};
</script>
<style scoped>
.my-purchase {
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  background-color: #f1f1f1;
}
/* tab */
.el-tabs {
  margin: 10px auto;
}
.my-purchase >>> .is-active {
  color: var(--primary-color) !important;
  font-size: 16px;
  font-weight: 500;
}
.my-purchase >>> .el-tabs__item:hover {
  color: var(--primary-color) !important;
  font-size: 16px;
  font-weight: 500;
}
/* pagination */
.pagination {
  width: 100%;
  height: 40px;
  margin: 10px 0;
  display: flex;
  justify-content: center;
}
.pagination
  >>> .el-pagination.is-background
  .el-pager
  li:not(.disabled).active {
  background-color: var(--primary-color);
  color: #ffffff;
}
.pagination >>> .el-pagination.is-background .el-pager li:not(.disabled) {
  color: #424242;
}
.el-tab-pane {
  padding: 20px 0 60px;
}
</style>
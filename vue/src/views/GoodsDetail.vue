<template>
  <div class="goods-detail">
    <el-page-header @back="goBack" content="商品详情"> </el-page-header>
    <div class="index">
      <div class="imgBox">
        <img :src="good.pic" alt="" />
      </div>
      <div class="desc">
        <div class="gname">
          {{ good.gname }}
          <div class="seller">
            <span>{{ good.username }}</span> 发布
          </div>
        </div>
        <div class="price">￥{{ good.price }}</div>
        <div class="remark">
          {{ good.remark }}
        </div>
        <div class="purchase">
          <el-button
            type="primary"
            style="width: 120px"
            @click="purchaseBtn"
            v-loading.fullscreen.lock="fullscreenLoading"
            element-loading-text="生成订单中"
            >立即购买</el-button
          >
          <el-button
            type="warning"
            style="width: 120px"
            @click="collectBtn"
            v-show="isCollected == false"
            >加入收藏</el-button
          >
          <el-button
            type="warning"
            style="width: 120px"
            @click="collectBtn"
            v-show="isCollected == true"
            disabled
            >已收藏</el-button
          >
        </div>
      </div>
    </div>
    <div class="message">
      <div class="send-message">
        <el-form :inline="true" :model="addMessage" label-width="80px">
          <el-form-item
            ><el-input
              placeholder="给卖家留言试试"
              v-model="addMessage.content"
            ></el-input
          ></el-form-item>
          <el-form-item
            ><el-button type="primary" style="width: 120px" @click="messageBtn"
              >发布留言</el-button
            ></el-form-item
          >
        </el-form>
      </div>
      <div class="message-list" v-if="isShowMsgList == true">
        <div class="list-item" v-for="item in message">
          <el-divider></el-divider>
          <div class="list-item-index">
            <div class="message-avatar content-item">
              <img :src="item.avatar" alt="" />
            </div>
            <div class="message-username content-item">{{ item.username }}</div>
            <div class="message-content content-item">
              {{ item.content }}
            </div>
            <div class="message-time content-item">
              {{ item.createTime }}
            </div>
            <span
              class="delBtn"
              @click="delBtn(item.mid)"
              v-if="item.showDelBtn == true"
              >删除</span
            >
          </div>
        </div>
      </div>
      <!-- 分页 -->
      <div class="pagination" v-if="isPaginationShow == true">
        <el-pagination
          background
          layout="prev, pager, next"
          :page-size="6"
          :total="total"
          @current-change="page"
        >
        </el-pagination>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      fullscreenLoading: false, //全屏加载
      isShowMsgList: false, //留言信息是否到达
      isCollected: false, //用户是否收藏该商品
      total: 0,
      isPaginationShow: false,
      gid: 1,
      uid: 1,
      good: {
        gid: 1,
        uid: 1,
        gname: "",
        price: 0,
        pic: "",
        status: 1,
        remark: "",
        cid: 1,
      },
      message: {
        mid: null,
        userId: null,
        username: "",
        avatar: "",
        goodId: null,
        gname: "",
        pic: "",
        content: "",
        createTime: "",
        showDelBtn: true,
      },
      addMessage: {
        userId: null,
        goodId: null,
        content: "",
      },
      collect: {
        userId: null,
        goodId: null,
      },
    };
  },
  watch: {
    total() {
      //监视总数，当总数超过6时显示分页，否则不显示
      this.isPaginationShow = this.total > 6 ? true : false;
    },
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    //请求：查询商品详情
    searchGoodsDetail(gid) {
      this.$axios.get("/goods/findGoodById/" + gid).then((res) => {
        this.good = res.data.data;
      });
    },
    //请求：查询留言列表
    searchMessageList(gid, uid, pageNum, pageSize) {
      this.$axios
        .get(
          "/findGoodMessage/" + gid + "/" + uid + "/" + pageNum + "/" + pageSize
        )
        .then((res) => {
          let msgInfo = res.data.data;
          if (msgInfo != null) {
            this.message = msgInfo.data;
            this.total = msgInfo.totalSize;
            this.isShowMsgList = true;
          } else {
            this.isShowMsgList = false;
          }
        });
    },
    //请求：查询是否收藏该商品
    searchIsCollected(uid, gid) {
      this.$axios.get("/findBookmark/" + uid + "/" + gid).then((res) => {
        this.isCollected = res.data;
      });
    },
    //请求：删除个人留言
    deleteMessage(mid) {
      this.$axios.post("/delMessage/" + mid);
    },
    //购买按钮
    purchaseBtn() {
      this.fullscreenLoading = true;
      setTimeout(() => {
        this.fullscreenLoading = false;
        this.$router.push({
          path: "/topay",
          query: {
            gid: this.gid,
          },
        });
      }, 1000);
    },
    //收藏按钮
    collectBtn() {
      this.collect.goodId = this.good.gid;
      this.collect.userId = localStorage.getItem("userId");
      this.$axios.post("/addBookmark", this.collect).then((res) => {
        this.isCollected = true;
        this.$message({
          message: "已加入收藏",
          type: "success",
        });
      });
    },
    //留言按钮
    messageBtn() {
      this.addMessage.userId = localStorage.getItem("userId");
      this.addMessage.goodId = this.good.gid;
      this.$axios.post("/addMessage", this.addMessage).then((res) => {
        this.$message({
          message: "留言成功",
          type: "success",
        });
        this.addMessage.content = "";
        //再次获取留言列表（刷新）
        this.searchMessageList(this.gid, this.uid, 1, 6);
      });
    },
    //删除留言按钮
    delBtn(mid) {
      this.$confirm("是否删除留言?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.deleteMessage(mid);
          this.reload();
          this.$message({
            type: "success",
            message: "删除成功!",
          });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },
    //分页
    page(currentPage) {
      this.$axios
        .get(
          "/findGoodMessage/" +
            this.good.gid +
            "/" +
            this.$store.getters.getUserId +
            "/" +
            currentPage +
            "/6"
        )
        .then((res) => {
          this.message = res.data.data.data;
          this.total = res.data.data.totalSize;
        });
    },
  },
  created() {
    this.gid = this.$route.query.gid;
    this.uid = this.$store.getters.getUserId;

    this.searchGoodsDetail(this.gid);
    this.searchMessageList(this.gid, this.uid, 1, 6);
    this.searchIsCollected(this.uid, this.gid);
  },
  inject: ["reload"],
};
</script>
<style scoped>
.el-input {
  width: 400px;
}
.goods-detail {
  margin: 0 auto;
  padding: 12px 12px;
  padding-bottom: 100px;
  width: 1200px;
  background-color: #fff;
}
/* 详情页index */
.index {
  width: 1000px;
  height: 400px;
  margin: 20px auto;
  display: flex;
}
.index .imgBox {
  width: 400px;
  height: 400px;
  overflow: hidden;
}
.index .imgBox img {
  width: 100%;
}
.index .desc {
  width: 500px;
  margin-left: 40px;
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
}
.index .desc .gname .seller {
  font-size: small;
  margin-top: 8px;
  color: #2e2e2e;
}
.index .desc .price {
  color: #27ae60;
  font-size: 28px;
}
.index .desc .remark {
  height: 100px;
}
.index .desc .gname {
  font-size: 36px;
  font-family: "Yuanti SC", Youyuan, "You Yuan", 幼圆, "PingFang SC",
    "Microsoft Yahei", Helvetica, sans-serif;
}
.index .desc .purchase .el-button {
  margin: 0 20px;
}
/* 留言页 */
.message {
  width: 1000px;
  margin: 0 auto;
}
.message .send-message {
  width: 800px;
  margin: 0 auto;
}
.message .message-list {
  width: 800px;
  margin: 0 auto;
}
.list-item-index {
  display: flex;
  align-items: center;
}
.list-item-index .content-item {
  margin-right: 10px;
}
.list-item-index .message-avatar {
  width: 40px;
  height: 40px;
  border-radius: 20px;
  background-color: rgb(173, 173, 173);
  overflow: hidden;
}
.list-item-index .message-avatar img {
  width: 100%;
}
.list-item-index .message-username {
  font-weight: 600;
  font-size: small;
  color: #27ae60;
}
.list-item-index .message-time {
  font-size: smaller;
  color: #7a7a7a;
}
/* pagination */
.pagination {
  width: 100%;
  display: flex;
  justify-content: center;
  margin-top: 20px;
}
.pagination
  >>> .el-pagination.is-background
  .el-pager
  li:not(.disabled).active {
  background-color: var(--primary-color);
  color: #ffffff;
}
.pagination >>> .el-pagination.is-background .el-pager li:not(.disabled) {
  /* background-color: var(--primary-color); */
  color: #424242;
}
.delBtn {
  font-size: small;
  cursor: pointer;
  margin-left: 20px;
}
.delBtn:hover {
  color: #f39c12;
}
</style>
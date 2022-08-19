<template>
  <div class="bookmark">
    <el-page-header @back="goBack" content="我的收藏"> </el-page-header>
    <!-- 有收藏商品时 -->
    <div class="bookmark-list" v-if="isHasGoods">
      <el-row>
        <el-col :span="8" v-for="(item, index) in goods">
          <el-card :body-style="{ padding: '0px' }" class="bookmark-list-item">
            <div class="img-box"><img :src="item.pic" class="image" /></div>
            <div style="padding: 14px">
              <span>{{ item.gname }}</span>
              <div class="bottom clearfix">
                <time class="time">{{ item.remark | ellipsis }}</time>
                <el-button
                  type="success"
                  icon="el-icon-search"
                  circle
                  @click="descBtn(item)"
                ></el-button>
                <el-button
                  type="danger"
                  icon="el-icon-delete"
                  circle
                  @click="delBtn(item)"
                ></el-button>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
      <div class="pagination">
        <el-pagination
          background
          layout="prev, pager, next"
          :page-size="9"
          :total="total"
          @current-change="page"
        >
        </el-pagination>
      </div>
    </div>
    <!-- 没有收藏商品时 -->
    <div class="no-goods" v-else>
      <NoResult msg="没有收藏的商品"></NoResult>
    </div>
  </div>
</template>
<script>
import NoResult from "../components/NoResult";
export default {
  components: { NoResult },
  data() {
    return {
      uid: null,
      total: 0,
      goods: {},
      isHasGoods: true, //是否有商品
    };
  },
  watch: {
    //监听goods是否为空
    goods() {
      this.isHasGoods = this.goods == null ? false : true;
    },
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    descBtn(item) {
      this.$router.push({
        path: "/goodsDetail",
        query: {
          gid: item.goodId,
        },
      });
    },
    delBtn(item) {
      this.$axios
        .post("/delBookmark", { userId: item.userId, goodId: item.goodId })
        .then((res) => {
          this.$message({
            message: "删除成功",
            type: "success",
          });
          //重新查询
          this.$axios
            .get("/findBookmark/" + localStorage.getItem("userId") + "/1/9")
            .then((res) => {
              if (res.data.data == null) {
                this.isHasGoods = false;
              } else {
                this.goods = res.data.data.data;
                this.total = res.data.data.totalSize;
              }
            });
        });
    },
    page(currentPage) {
      console.log("当前页数：", currentPage);
      this.$axios
        .get(
          "/findBookmark/" +
            localStorage.getItem("userId") +
            "/" +
            currentPage +
            "/9"
        )
        .then((res) => {
          this.goods = res.data.data.data;
          this.total = res.data.data.totalSize;
        });
    },
  },
  filters: {
    ellipsis(value) {
      //字数过滤器，用于限制商品详情的字数显示
      if (!value) return "";
      if (value.length > 10) {
        return value.slice(0, 10) + "...";
      }
      return value;
    },
  },
  created() {
    this.$axios
      .get("/findBookmark/" + localStorage.getItem("userId") + "/1/9")
      .then((res) => {
        console.log(res);
        if (res.data.data == null) {
          this.isHasGoods = false;
        } else {
          this.goods = res.data.data.data;
          this.total = res.data.data.totalSize;
        }
      });
  },
};
</script>
<style scoped>
.bookmark {
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  height: 1500px;
  background-color: #fff;
}
.bookmark-list {
  width: 95%;
  margin: 0 auto;
}
.bookmark-list-item {
  width: 300px;
  margin: 20px 0;
}
/* ----卡片----- */
.time {
  font-size: 13px;
  color: #999;
  margin-right: 40px;
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  padding: 0;
  float: right;
}
.img-box {
  height: 300px;
  overflow: hidden;
}
.image {
  width: 100%;
  /* height: 100%; */
  display: block;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both;
}
/* --------- */
/* 分页 */
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
/* 没有商品 */
.no-goods {
  width: 100%;
  height: 500px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.no-goods img {
  width: 300px;
}
</style>
<template>
  <div class="search">
    <el-page-header @back="goBack" content="搜索商品"> </el-page-header>
    <div class="search-result">
      <!-- 没有搜索结果 -->
      <div class="no-goods" v-if="isHasGoods == false">
        <img src="../assets/no-goods.png" alt="没有搜索到相关商品" />
        <div>没有搜索到相关商品</div>
      </div>
      <!-- 搜索结果 -->
      <el-row v-else>
        <el-col :span="8" v-for="item in goods">
          <el-card :body-style="{ padding: '0px' }" class="card-item">
            <div class="img-box" @click="toGoodsDetail(item)">
              <img :src="item.pic" class="image" />
            </div>
            <div class="gname" @click="toGoodsDetail(item)">
              <span>{{ item.gname }}</span>
            </div>
            <div class="other" @click="toGoodsDetail(item)">
              <span class="remark">
                {{ item.remark | ellipsis_remark }}
              </span>
              <span class="price">￥{{ item.price }}</span>
            </div>
          </el-card>
        </el-col>
      </el-row>
      <!-- pagination -->
      <div class="pagination" v-show="isShowPagination">
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
  </div>
</template>
<script>
export default {
  data() {
    return {
      goods: {},
      total: 0,
      isShowPagination: false,
      isHasGoods: false,
    };
  },
  watch: {
    $route() {
      let input = this.$route.query.input;
      this.search(input, 1);
    },
    total() {
      this.isShowPagination = this.total > 9 ? true : false;
      this.isHasGoods = this.total == 0 ? false : true;
    },
  },
  filters: {
    ellipsis_remark(value) {
      if (!value) return "";
      if (value.length > 10) {
        return value.slice(0, 10) + "...";
      }
      return value;
    },
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    search(input, currentPage) {
      //搜索方法
      this.$axios
        .get("/goods/findGoodsBySelect/" + input + "/" + currentPage + "/9")
        .then((res) => {
          let pageInfo = res.data.data;//pageInfo {data,totalSize,pageNum,pageSize}
          this.total = pageInfo.totalSize; //获取查询总数
          if (pageInfo.totalSize != 0) {
            this.goods = pageInfo.data;
            this.isHasGoods = true;
            console.log(
              "搜索",
              input,
              "共",
              this.total,
              "条",
              "搜索结果：",
              this.goods
            );
          }
        });
    },
    page(currentPage) {
      //分页方法
      let input = this.$route.query.input;
      this.search(input, currentPage);
    },
    toGoodsDetail(item) {
      //跳转到商品详情
      this.$router.push({
        path: "/goodsDetail",
        query: {
          gid: item.gid,
        },
      });
    },
  },
  created() {
    let input = this.$route.query.input;
    this.search(input, 1);
  },
};
</script>
<style scoped>
.search {
  margin: 0 auto;
  padding: 12px 12px;
  padding-bottom: 100px;
  background-color: #fff;
  width: 1200px;
}
/* 没有搜索结果 */
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
.el-col {
  display: flex;
  justify-content: center;
  margin: 20px 0;
}
.el-card {
  width: 280px;
  cursor: pointer;
}
.img-box {
  width: 100%;
  height: 260px;
  overflow: hidden;
}
.img-box img {
  width: 100%;
}
.gname {
  padding: 14px;
}
.other {
  padding: 0 14px 14px;
  color: rgb(59, 59, 59);
}
.other .remark {
  font-size: 14px;
}
.other .price {
  color: #16a085;
  float: right;
  font-size: 20px;
}
/* hover图片放大效果 */
.card-item .image {
  width: 100%;
  display: block;
  cursor: pointer;
  transition: all 0.8s 0.1s;
}
.card-item:hover .image {
  transform: scale(1.1);
}
.card-item .img-box {
  overflow: hidden;
}
/* pagination */
.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 2% 0;
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
</style>
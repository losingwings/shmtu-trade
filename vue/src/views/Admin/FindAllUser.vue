<template>
  <div>
    <el-table :data="tableData" border style="width: 100%">
      <el-table-column fixed prop="uid" label="账号" width="100" align="center">
      </el-table-column>
      <el-table-column prop="username" label="姓名" width="100" align="center">
      </el-table-column>
      <el-table-column prop="money" label="余额" width="120" align="center">
      </el-table-column>
      <el-table-column
        prop="location"
        label="地址"
        width="280"
        align="center"
        show-overflow-tooltip
      >
      </el-table-column>
      <el-table-column prop="sex" label="性别" width="100" align="center">
      </el-table-column>
      <el-table-column prop="tel" label="手机" width="160" align="center">
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="140" align="center">
        <template slot-scope="scope">
          <el-button @click="edit(scope.row)" type="text" size="small"
            >修改</el-button
          >
          <el-button @click="deleteUser(scope.row)" type="text" size="small"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <div class="pagination-div">
      <el-pagination
        background
        layout="prev, pager, next"
        :page-size="7"
        :total="total"
        @current-change="page"
      >
      </el-pagination>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      total: 0,
      tableData: [],
      user: {
        name: "",
        password: "",
        age: null,
        sex: "",
      },
    };
  },
  methods: {
    edit(row) {
      this.$router.push({
        path: "/updateUser",
        query: {
          uid: row.uid,
        },
      });
      console.log(row.uid);
    },
    deleteUser(row) {
      this.$confirm("此操作将永久删除信息, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          console.log("uid:", row.uid);
          this.$axios.post("/admin/deleteUserInfo/" + row.uid);
        })
        .then((res) => {
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
    page(currentPage) {
      this.$axios
        .get("/admin/findUserInfoByPage/" + currentPage + "/7")
        .then((res) => {
          this.tableData = res.data.data.data;
          this.total = res.data.data.totalSize;
        });
    },
  },
  created() {
    this.$axios.get("/admin/findUserInfoByPage/1/7").then((res) => {
      this.tableData = res.data.data.data;
      this.total = res.data.data.totalSize;
      console.log("totalSize:", this.total);
      console.log(
        "获取到了用户列表数据",
        this.tableData,
        "共",
        this.total,
        "条"
      );
    });
  },
  inject: ["reload"],
};
</script>
<style scoped>
.el-table--border,
.el-table--group {
  border: none;
}
.pagination-div {
  width: 100%;
  height: 80px;
  display: flex;
  padding: 20px 20px;
}
</style>
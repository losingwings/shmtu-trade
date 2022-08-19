<template>
  <div class="admin">
    <!-- container -->
    <el-header style="text-align: right; font-size: 12px" class="flex">
      <div class="title-div">
        <span class="title">校园二手交易商城后台管理系统</span>
      </div>
      <div>
        <el-dropdown @command="handleCommand">
          <i class="el-icon-setting" style="margin-right: 15px"></i>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="logout">退出</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
        <!-- <span><a>{{user.name}}</a></span> -->
      </div>
    </el-header>
    <el-container>
      <!-- aside -->
      <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
        <el-menu router :default-openeds="['0', '1']">
          <el-submenu
            v-for="(item, index) in $router.options.routes"
            :index="String(index)"
            v-if="item.show"
          >
            <template slot="title">
              <i class="el-icon-setting"></i>
              {{ item.name }}
            </template>
            <el-menu-item
              v-for="(item2, index2) in item.children"
              :index="item2.path"
              :class="$route.path == item2.path ? 'is-active' : ''"
              v-if="item2.show"
            >
              {{ item2.name }}
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </el-aside>
      <!-- main -->
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      admin: "",
    };
  },
  methods: {
    handleCommand(command) {
      if (command == "logout") {
        this.$router.push("/home");
        this.$message({
          type: "success",
          message: "已退出后台管理界面",
        });
      }
    },
  },
};
</script>

<style scoped>
.admin {
  background-color: #fff;
}
.flex {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.title {
  float: left;
  user-select: none;
  font-size: 24px;
  color: #3498db;
}

.title-div {
  width: 80%;
  height: 60px;
  line-height: 60px;
  float: left;
}
.el-main {
  padding: 0;
  margin: 0;
}
.el-container {
  height: calc(100vh - 60px);
  border: 1px solid #eee;
}
</style>

<template>
  <div class="no-goods">
    <img src="../assets/no-goods.png" alt="没有已收藏的商品" />
    <div>{{msg}}</div>
  </div>
</template>
<script>
export default {
    props: ["msg"]
}
</script>
<style scoped>
.no-goods {
  width: 80%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.no-goods img {
  width: 30%;
}
</style>
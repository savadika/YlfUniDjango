<template>
  <div class="app-container bu-index">
    <h2>业务中心</h2>
    <p class="desc">此页面为业务中心容器视图，用于承载其子页面。</p>
    <router-view />
  </div>
</template>

<script>
export default {
  name: 'BuIndex'
}
</script>

<style scoped>
.bu-index { padding: 16px; }
.desc { color: #909399; margin-top: 6px; }
</style>
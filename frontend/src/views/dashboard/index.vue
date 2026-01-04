<template>
  <div class="dashboard-container">
    <div class="dashboard-header">
      <div class="dashboard-title">欢迎，{{ name }}</div>
    </div>

    <el-row :gutter="20" class="panel-group">
      <el-col :xs="24" :sm="12" :md="8">
        <el-card class="panel-item panel-users" shadow="hover" v-loading="statsLoading">
          <div class="panel-body">
            <i class="el-icon-user panel-icon" />
            <div class="panel-content">
              <div class="panel-label">用户数</div>
              <div class="panel-value">{{ formatNumber(userCount) }}</div>
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :xs="24" :sm="12" :md="8">
        <el-card class="panel-item panel-orders" shadow="hover" v-loading="statsLoading">
          <div class="panel-body">
            <i class="el-icon-document panel-icon" />
            <div class="panel-content">
              <div class="panel-label">订单数</div>
              <div class="panel-value">{{ formatNumber(orderCount) }}</div>
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :xs="24" :sm="12" :md="8">
        <el-card class="panel-item panel-amount" shadow="hover" v-loading="statsLoading">
          <div class="panel-body">
            <i class="el-icon-money panel-icon" />
            <div class="panel-content">
              <div class="panel-label">金额</div>
              <div class="panel-value">{{ formatAmount(amountTotal) }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Dashboard',
  data() {
    return {
      statsLoading: false,
      userCount: null,
      orderCount: null,
      amountTotal: null
    }
  },
  computed: {
    ...mapGetters(['name'])
  },
  created() {
    this.generateStats()
  },
  methods: {
    generateStats() {
      this.statsLoading = true
      setTimeout(() => {
        this.userCount = this.randomInt(1200, 5600)
        this.orderCount = this.randomInt(300, 1500)
        const base = this.randomInt(50000, 300000)
        this.amountTotal = base + Math.random() * 1000
        this.statsLoading = false
      }, 300)
    },
    randomInt(min, max) {
      return Math.floor(Math.random() * (max - min + 1)) + min
    },
    formatNumber(n) {
      if (n === null || n === undefined) return '—'
      return String(n).replace(/\B(?=(\d{3})+(?!\d))/g, ',')
    },
    formatAmount(n) {
      if (n === null || n === undefined) return '—'
      return Number(n).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-container { padding: 24px; }
.dashboard-title { font-size: 22px; font-weight: 600; color: #303133; margin-bottom: 16px; }
.panel-group { margin-top: 8px; }
.panel-item { border: none; color: #fff; border-radius: 12px; overflow: hidden; }
.panel-item .el-card__body { padding: 28px 22px; }
.panel-body { display: flex; align-items: center; min-height: 110px; }
.panel-icon { font-size: 48px; margin-right: 16px; opacity: 0.9; }
.panel-content { display: flex; flex-direction: column; }
.panel-label { font-size: 14px; opacity: 0.9; }
.panel-value { margin-top: 6px; font-size: 32px; font-weight: 700; }
.panel-users { background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%); }
.panel-orders { background: linear-gradient(135deg, #ff7e5f 0%, #feb47b 100%); }
.panel-amount { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
</style>

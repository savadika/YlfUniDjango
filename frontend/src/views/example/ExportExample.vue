<template>
  <div class="app-container">
    <div class="filter-container">
      <el-input
        v-model="listQuery.title"
        placeholder="标题"
        style="width: 200px;"
        class="filter-item"
        @keyup.enter.native="handleFilter"
      />
      <el-select
        v-model="listQuery.status"
        placeholder="状态"
        clearable
        style="width: 120px"
        class="filter-item"
      >
        <el-option value="published" label="已发布" />
        <el-option value="draft" label="草稿" />
      </el-select>
      <el-button
        class="filter-item"
        type="primary"
        icon="el-icon-search"
        @click="handleFilter"
      >
        搜索
      </el-button>
      
      <!-- 使用通用导出组件 -->
      <export-button
        :api-function="getList"
        :search-params="getSearchParams()"
        :export-options="exportOptions"
        @export-success="onExportSuccess"
        @export-error="onExportError"
      />
      
      <!-- 或者使用混入方法 -->
      <el-dropdown @command="handleExportCommand" style="margin-left: 10px;">
        <el-button type="warning" :loading="exportLoading">
          混入导出 <i class="el-icon-arrow-down el-icon--right"></i>
        </el-button>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="excel">Excel格式</el-dropdown-item>
          <el-dropdown-item command="csv">CSV格式</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>

    <el-table
      v-loading="listLoading"
      :data="list"
      element-loading-text="Loading"
      border
      fit
      highlight-current-row
    >
      <el-table-column align="center" label="ID" width="95">
        <template slot-scope="{row}">
          {{ row.id }}
        </template>
      </el-table-column>
      <el-table-column label="标题">
        <template slot-scope="{row}">
          {{ row.title }}
        </template>
      </el-table-column>
      <el-table-column label="作者" width="110" align="center">
        <template slot-scope="{row}">
          <span>{{ row.author }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" class-name="status-col" width="100">
        <template slot-scope="{row}">
          <el-tag :type="row.status | statusFilter">
            {{ row.status }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column align="center" prop="created_at" label="创建时间" width="200">
        <template slot-scope="{row}">
          <i class="el-icon-time" />
          <span>{{ row.display_time }}</span>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      v-show="total>0"
      :current-page="listQuery.page"
      :page-sizes="[10, 20, 30, 50]"
      :page-size="listQuery.limit"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>
</template>

<script>
import { getList } from '@/api/table'
import ExportButton from '@/components/ExportButton'
import exportMixin from '@/utils/exportMixin'

export default {
  name: 'ExportExample',
  components: { ExportButton },

  mixins: [exportMixin], // 使用导出混入
  filters: {
    statusFilter(status) {
      const statusMap = {
        published: 'success',
        draft: 'gray',
        deleted: 'danger'
      }
      return statusMap[status]
    }
  },
  data() {
    return {
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        page: 1,
        limit: 20,
        title: undefined,
        status: undefined
      },
      // 导出配置
      exportOptions: {
        filename: '文章列表',
        headers: {
          id: 'ID',
          title: '标题',
          author: '作者',
          status: '状态',
          display_time: '创建时间'
        },
        sheetName: '文章数据'
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.listLoading = true
      getList(this.listQuery).then(response => {
        this.list = response.data.items
        this.total = response.data.total
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.page = 1
      this.getList()
    },
    getSearchParams() {
      // 过滤空值参数
      const params = {}
      Object.keys(this.listQuery).forEach(key => {
        if (this.listQuery[key] !== undefined && this.listQuery[key] !== '') {
          params[key] = this.listQuery[key]
        }
      })
      // 移除分页参数，导出时会自动处理
      delete params.page
      delete params.limit
      return params
    },
    
    // 导出组件事件处理
    onExportSuccess(data) {
      console.log('导出成功:', data)
      // 可以在这里添加成功后的逻辑，比如统计导出次数
    },
    onExportError(error) {
      console.error('导出失败:', error)
      // 可以在这里添加错误处理逻辑，比如错误上报
    },
    
    // 分页处理
    handleSizeChange(val) {
      this.listQuery.limit = val
      this.getList()
    },
    handleCurrentChange(val) {
      this.listQuery.page = val
      this.getList()
    },
    
    // 使用混入方法的导出
    async handleExportCommand(format) {
      try {
        await this.exportData(
          getList,
          this.getSearchParams(),
          this.exportOptions,
          format
        )
      } catch (error) {
        // 错误已在混入中处理
      }
    }
  }
}
</script>

<style scoped>
.filter-container {
  padding-bottom: 10px;
}
.filter-item {
  display: inline-block;
  vertical-align: middle;
  margin-bottom: 10px;
  margin-right: 10px;
}
</style>
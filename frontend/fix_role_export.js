import VueTemplateGenerator from './src/utils/generator/vueTemplateGenerator.js';
import fs from 'fs';
import path from 'path';

const config = {
  moduleName: '角色管理',
  moduleKey: 'role',
  fields: [
    { key: 'id', label: 'ID', type: 'number', showInTable: true, exportable: true },
    { key: 'name', label: '角色名称', type: 'string', required: true, searchable: true, defaultSearch: true, showInTable: true, exportable: true },
    { key: 'code', label: '角色编码', type: 'string', required: true, searchable: true, defaultSearch: true, showInTable: true, exportable: true },
    { key: 'create_time', label: '创建时间', type: 'datetime', searchable: true, showInTable: true, exportable: true },
    { key: 'update_time', label: '更新时间', type: 'datetime', searchable: true, showInTable: true, exportable: true },
    { key: 'remark', label: '备注', type: 'text', searchable: true, showInTable: true, exportable: true }
  ],
  options: {
    enableSearch: true,
    enableExport: true,
    enablePagination: true,
    enableBatchDelete: true
  }
};

console.log('重新生成角色管理页面，确保包含导出功能...');
const generator = new VueTemplateGenerator(config);
const vueCode = generator.generate();

// 检查生成的代码是否包含导出按钮
if (vueCode.includes('<export-button') && vueCode.includes('ExportButton')) {
  console.log('✅ 导出按钮已包含在生成的代码中');
} else {
  console.log('❌ 警告：生成的代码中未找到导出按钮');
}

const outputPath = path.join('src/views/role', 'index.vue');
fs.writeFileSync(outputPath, vueCode, 'utf8');
console.log('角色管理页面已重新生成:', outputPath);
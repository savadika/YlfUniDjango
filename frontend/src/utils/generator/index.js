/**
 * 代码生成器入口文件
 * 统一导出所有生成器相关的类和工具
 */

// 本地导入，确保默认导出对象中的标识符在运行时有绑定
import { ModuleGenerator, GeneratorFactory, BatchGenerator } from './moduleGenerator.js'
import { FieldConfig, ConfigBuilder, CommonFields, ModuleTemplates } from './fieldConfig.js'
import VueTemplateGenerator from './vueTemplateGenerator.js'
import { ApiTemplateGenerator, ApiDocGenerator } from './apiTemplateGenerator.js'
import { RouterTemplateGenerator, RouterRegistrar, BreadcrumbGenerator, MenuGenerator } from './routerTemplateGenerator.js'
import { examples, runAllExamples } from './examples.js'

// 维持原有的命名导出（向后兼容）
export { ModuleGenerator, GeneratorFactory, BatchGenerator }
export { FieldConfig, ConfigBuilder, CommonFields, ModuleTemplates }
export { VueTemplateGenerator }
export { ApiTemplateGenerator, ApiDocGenerator }
export { RouterTemplateGenerator, RouterRegistrar, BreadcrumbGenerator, MenuGenerator }
export { examples, runAllExamples }

// 默认导出主要的生成器工厂及常用工具
export default {
  GeneratorFactory,
  ModuleGenerator,
  ConfigBuilder,
  CommonFields,
  examples
}
import permission from './permission'
import checkPermission from '@/utils/hasPermission'

const install = function(Vue) {
  Vue.directive('permission', permission)
  Vue.prototype.$checkPermission = checkPermission
}

if (window.Vue) {
  window.Vue.use(install); // eslint-disable-line
}

permission.install = install
export default permission

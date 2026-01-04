import checkPermission from '@/utils/hasPermission'

function permissionFunction(el, binding) {
  const { value } = binding
  
  if (!checkPermission(value)) {
    el.parentNode && el.parentNode.removeChild(el)
  }
}

export default {
  inserted(el, binding) {
    permissionFunction(el, binding)
  },
  update(el, binding) {
    permissionFunction(el, binding)
  }
}

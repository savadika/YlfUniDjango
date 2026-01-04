const getters = {
  sidebar: state => state.app.sidebar,
  device: state => state.app.device,
  token: state => state.user.token,
  id: state => state.user.id,
  avatar: state => state.user.avatar,
  name: state => state.user.name,
  permissions: state => state.user.permissions, // 按钮权限
  menus: state => state.user.menus,  // 获取菜单
  permission_routes: state => state.permission.routes, // 供侧边栏使用
}
export default getters

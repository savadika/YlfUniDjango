import Cookies from 'js-cookie'

//进行token的存储与读取，TokenKey就是键

const TokenKey = 'Authorization'

export function getToken() {
  return localStorage.getItem(TokenKey) || ''
}

export function setToken(token) {
  return localStorage.setItem(TokenKey, token)
}

export function removeToken() {
  return localStorage.removeItem(TokenKey)
}

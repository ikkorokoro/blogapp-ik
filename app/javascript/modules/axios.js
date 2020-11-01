import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

export default axios
/* default axiosで記述するとimportするときは{}がいらなくなる
  ＝＝＝＝＝＝＝＝例＝＝＝＝＝＝＝＝＝
  imoprt axios from 'module/axios'と書ける*/

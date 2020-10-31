import $ from 'jquery'
import axios from 'modules/axios'



const listenInactiveHeartEvent = (articleId) => {
/* .inactive-heartをクリックした時、postリクエストを送ってresponseが'ok'の時
      .active-heartの.hiddenを削除し、inactive-heartに.hiddenを追加する
      もし違う時alert('Error')とconsole.logにエラーを表示 */
      $('.inactive-heart').on('click', () => {
        axios.post(`/articles/${articleId}/like`)
          .then((response) => {
            if (response.data.status === 'ok') {
              $('.active-heart').removeClass('hidden')
              $('.inactive-heart').addClass('hidden')
            }
          })
          .catch((e) => {
            window.alert('Error')
            console.log(e)
          })
      })
}


const listenActiveHeartEvent = (articleId) => {
/* .active-heartをクリックした時、postリクエストを送ってresponseが'ok'の時
.active-heartに.hiddenを追加する.inactive-heartの.hiddenを削除 
もし違う時alert('Error')とconsole.logにエラーを表示*/
$('.active-heart').on('click', () => {
  axios.delete(`/articles/${articleId}/like`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $('.active-heart').addClass('hidden')
        $('.inactive-heart').removeClass('hidden')
      }
    })
    .catch((e) => {
      window.alert('Error')
      console.log(e)
    })
})
}

export {
  listenInactiveHeartEvent,
  listenActiveHeartEvent
  //プロパティと値が一緒の時は省略して書くこともできる
  //javascriptで書く場合バージョンによって省略記法がかけない場合があるので注意する
}
/* listenInactiveHeartEvent: listenInactiveHeartEvent, 
    listenActiveHeartEvent: listenActiveHeartEvent 
    このように書くこともできるが*/

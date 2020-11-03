import $ from 'jquery'
import axios from 'modules/axios'
import {
  listenInactiveHeartEvent,
  listenActiveHeartEvent
}from 'modules/handle_heart'

//================関数=====================

const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $('.active-heart').removeClass('hidden')
  } else {
    $('.inactive-heart').removeClass('hidden')
  }
}

const handleControllerForm = () => {
  /* .show-commentをクリックすると.show-commentに.hiddenが追加され
      .comment-text-areaの.hiddenが削除される*/
  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('hidden')
    $('.comment-text-area').removeClass('hidden')
  })
}

const appendNewComment = (comment) => {
  $('.comments-container').append(//appendはタグの中にhtmlのタグを追加していく
    `<div class="article_comment"><p>${escape(comment.content)}</p></div>`
  )
}


//======================================================================



document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId//articleIdを取得
  /* getリクエストを送り, commetsを取得し,
  それを一つずつ.comments-containerに追加する */
  axios.get(`/api/articles/${articleId}/comments`)
    .then((response) => {
      const comments = response.data
      comments.forEach((comment) => { //foreachはeachと同じ
        appendNewComment(comment)
      })
    })
    .catch((error) => {
      window.alert('失敗')
    })
  handleControllerForm()



  $('.add-comment-button').on('click', () => {
    const content = $('#comment_content').val()//.valは属性の値を取得する
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/api/articles/${articleId}/comments`, {
        comment: { content: content }//parameterの指定をする.ハッシュのハッシュの構造にする
      })
        .then((res) => { //resが帰ってきたらcomment追加する
          const comment = res.data
          appendNewComment(comment)
          $('#comment_content').val('')//コメント追加後にformの中を空にする
        })
    }
  })

  /* 自分がいいねしているなら.active-heartを表示
  いいねしていないなら.inactive-heartを表示する */
  axios.get(`/api/articles/${articleId}/like`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      //可読性を上げるため関数としてコードを分けて記述する
      handleHeartDisplay(hasLiked)
    })

    listenInactiveHeartEvent(articleId)
    listenActiveHeartEvent(articleId)
  })
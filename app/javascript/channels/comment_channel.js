import consumer from "channels/consumer"

let commentSubscription = null

const connectCommentChannel = () => {
  const itemId = location.pathname.match(/\d+/)?.[0]
  if (!itemId) return

  // 既存サブスクリプションがあれば削除
  if (commentSubscription) {
    consumer.subscriptions.remove(commentSubscription)
  }

  commentSubscription = consumer.subscriptions.create(
    { channel: "CommentChannel", item_id: itemId },
    {
      connected() {
        // サーバーと接続されたとき
        console.log(`Connected to CommentChannel for item ${itemId}`)
      },

      disconnected() {
        // 切断時
        console.log(`Disconnected from CommentChannel for item ${itemId}`)
      },

      received(data) {
        const html = `
          <div class="comment">
            <p class="user-info">${data.user.nickname}：</p>
            <p>${data.comment.text}</p>
          </div>`
        const comments = document.getElementById("comments")
        if (comments) {
          comments.insertAdjacentHTML("beforeend", html)
          comments.scrollTop = comments.scrollHeight // 最新へスクロール
        }
        const commentForm = document.getElementById("comment-form")
        if (commentForm) commentForm.reset()
      }
    }
  )
}

// Turbo Drive に対応（ページ遷移後にも必ず呼ばれる）
document.addEventListener("turbo:load", connectCommentChannel)
document.addEventListener("turbo:frame-load", connectCommentChannel)
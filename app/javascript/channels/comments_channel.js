import consumer from "./consumer"

consumer.subscriptions.create("CommentsChannel",{
  connected() {

  },

  disconnected() {

  },

  received(data) {
    $('#messages .comment-fix:first').prepend(data)
  }
});
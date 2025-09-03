class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = Comment.new(comment_params)

    if @comment.save
      # 成功時はActionCableで全ユーザーに送信
      CommentChannel.broadcast_to @item, { comment: @comment, user: @comment.user }
      head :ok
    else
      # 失敗時は投稿者だけにJSONで返す
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end

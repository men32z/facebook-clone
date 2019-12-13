class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
      flash.now[:success] = 'Comment created'
    else
      flash.now[:danger] = 'Some errors'
    end
    redirect_to user_path(current_user)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end

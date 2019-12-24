# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :login_verify
  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      flash.now[:success] = 'Post created'
    else
      flash.now[:danger] = 'Some errors'
    end
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end

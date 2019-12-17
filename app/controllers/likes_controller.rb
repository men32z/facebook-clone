# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    like = Like.where(post_id: params[:post_id], user_id: current_user.id).first
    if like.nil?
      like = Like.new(post_id: params[:post_id], user_id: current_user.id)
      flash.now[:danger] = 'Some errors' unless like.save
    end
    redirect_to user_path(current_user)
  end
end

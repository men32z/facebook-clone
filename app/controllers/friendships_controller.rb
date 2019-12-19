# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
    friendship.confirmed = false
    if friendship.save
      flash.now[:success] = 'Friend request sent'
    else
      flash.now[:danger] = 'Some errors'
    end
    redirect_to friendships_path
  end

  def index; end

  def update
    # confirm only if we are involved.

    friendship = Friendship.where(id: params[:id], user_id: current_user.id, friend_id: params[:user_id]).first

    friendship&.confirmed = true
    friendship&.save
    redirect_to friendships_path
  end

  def destroy
    friendship = Friendship.find_by(id: params[:id])
    user = User.find_by(id: params[:user_id])
    # prevent deletion of other peoples friendships via injection
    my_friend = friendship.user_id == current_user.id || friendship.friend_id == current_user.id
    friendship.delete if current_user.friend?(user) && my_friend
    redirect_to friendships_path
  end
end

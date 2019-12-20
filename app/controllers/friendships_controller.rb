# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
    if friendship.save
      flash.now[:success] = 'Friend request sent'
    else
      flash.now[:danger] = 'Some errors'
    end
    redirect_to friendships_path
  end

  def index; end

  def update
    friendship = Friendship.new(user_id: current_user.id, friend_id: params[:user_id])
    if friendship.save
      flash.now[:success] = 'Friend request sent'
    else
      flash.now[:danger] = 'Some errors'
    end
    redirect_to friendships_path
  end

  def destroy
    friendship = Friendship.where(user_id: current_user.id, friend_id: params[:user_id]).first
    mirror = Friendship.where(user_id: params[:user_id], friend_id: current_user.id).first
    friendship.delete
    mirror.delete
    redirect_to friendships_path
  end
end

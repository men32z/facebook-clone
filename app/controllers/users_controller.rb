# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.where("id !=  #{current_user.id}")
  end

  def show
    @post = Post.new
    @comment = Comment.new
    @user = User.find_by(id: params[:id])
    return if @user

    flash.now[:danger] = 'user not found'
    redirect_to root_path
  end

  def edit
    @user = User.find_by(id: params[:id])
    return if @user

    flash.now[:danger] = 'user not found'
    redirect_to root_path
  end

  def update
    user = User.find_by(id: params[:id])
    user.update(user_params)
    if user&.save
      flash.now[:success] = 'user saved'
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'user not found, or can\'t save'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :bio, :photo)
  end
end

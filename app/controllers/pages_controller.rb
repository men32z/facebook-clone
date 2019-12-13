# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    if user_signed_in?
      @post = Post.new
      @posts = Post.all
      render 'timeline'
    else
      render 'index'
    end

  end
end

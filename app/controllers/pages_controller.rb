# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    if user_signed_in?
      @post = Post.new
      @posts = Post.order(:id).reverse_order
      render 'timeline'
    else
      render 'index'
    end
  end
end

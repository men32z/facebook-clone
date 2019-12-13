# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @post = Post.new
  end
end

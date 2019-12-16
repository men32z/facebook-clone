# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:valid_user) do
    has_x = { name: 'mike', email: 'mikew@monsterinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  it 'it should be reated' do
    user = User.create(valid_user)
    post = Post.create(content: 'asdf', user_id: user.id)
    like = Like.new(user_id: user.id, post_id: post.id)
    expect(like).to be_valid
    expect do
      like.save
    end.to change(Like, :count).by(1)
  end

  it 'should have an user' do
    user = User.create(valid_user)
    post = Post.create(content: 'asdf', user_id: user.id)
    like = Like.create(user_id: user.id, post_id: post.id)
    expect(like.user.id).to eq(user.id)
  end

  it 'should have a post' do
    user = User.create(valid_user)
    post = Post.create(content: 'asdf', user_id: user.id)
    like = Like.create(user_id: user.id, post_id: post.id)
    expect(like.post.id).to eq(post.id)
  end
end

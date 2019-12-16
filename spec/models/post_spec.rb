# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:valid_user) do
    has_x = { name: 'mike', email: 'mikew@monsterinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  it 'it should be valid with valid attributes' do
    user = User.create(valid_user)
    post = Post.new(content: 'asdf', user_id: user.id)
    expect(post).to be_valid
    post.content = 'a' * 279
    expect do
      post.save
    end.to change(Post, :count).by(1)
  end

  it 'it should not be valid with empty content or more than 280 characters' do
    user = User.create(valid_user)
    post = Post.new(user_id: user.id)
    expect(post).to_not be_valid
    post.content = ''
    expect(post).to_not be_valid
    post.content = 'a' * 281
    expect(post).to_not be_valid
  end

  it 'should show user' do
    user = User.create(valid_user)
    post = Post.create(content: 'asdf', user_id: user.id)
    expect(post.user.id).to eq(user.id)
  end
end

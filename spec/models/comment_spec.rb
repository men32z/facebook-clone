require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:valid_user) do
    has_x = { name: 'mike', email: 'mikew@monsterinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  it 'it should be valid with valid attributes' do
    user = User.create(valid_user)
    post = Post.create(content: 'asdf', user_id: user.id)
    comment = Comment.new(content: 'Comment example', user_id: user.id, post_id: post.id)
    expect(comment).to be_valid
    comment.content = 'a' * 140
    expect do
      comment.save
    end.to change(Comment, :count).by(1)
  end

  it 'it should not be valid with empty content or more than 140 characters' do
    user = User.create(valid_user)
    post = Post.create(content: 'asdf', user_id: user.id)
    comment = Comment.new(user_id: user.id, post_id: post.id)
    expect(comment).to_not be_valid
    comment.content = ''
    expect(comment).to_not be_valid
    comment.content = 'a' * 141
    expect(comment).to_not be_valid
  end

  it 'should show user' do
    user = User.create(valid_user)
    post = Post.create(content: 'asdf', user_id: user.id)
    comment = Comment.new(content: 'Comment example', user_id: user.id, post_id: post.id)
    expect(comment.user.id).to eq(user.id)
  end

  it 'should have a post' do
    user = User.create(valid_user)
    post = Post.create(content: 'asdf', user_id: user.id)
    comment = Comment.new(content: 'Comment example', user_id: user.id, post_id: post.id)
    expect(comment.post.id).to eq(post.id)
  end
end
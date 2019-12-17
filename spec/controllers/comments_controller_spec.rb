# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  describe 'POST#create' do
    it 'creates a comment' do
      comment_content = 'Example Comment'
      user = User.create(user_valid)
      sign_in user
      user_post = user.posts.create(content: 'Example Post')
      post :create, params: { comment: { post_id: user_post.id, content: comment_content } }
      expect(response).to have_http_status(302)
      expect(Comment.last.content).to eq(comment_content)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  describe 'POST#create' do
    it 'creates a post' do
      user = User.create(user_valid)
      sign_in user
      content = 'content example'
      post :create, params: { post: { content: content } }
      expect(response).to have_http_status(302)
      expect(Post.last.content).to eq(content)
    end
  end
end

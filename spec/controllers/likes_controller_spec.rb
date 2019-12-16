# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  describe 'POST#create' do
    it 'creates a Like' do
      user = User.create(user_valid)
      sign_in user
      user_post = user.posts.create(content: 'Example Post')
      expect do
        post :create, params: { post_id: user_post.id }
        expect(response).to have_http_status(302)
      end.to change(Like, :count).by(1)
    end
  end
end

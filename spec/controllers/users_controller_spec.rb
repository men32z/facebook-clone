# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  describe 'GET#show' do
    it 'returns http success' do
      user = User.create(user_valid)
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET#edit' do
    it 'returns http success' do
      user = User.create(user_valid)
      sign_in user
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH#update' do
    it 'returns http success' do
      user = User.create(user_valid)
      sign_in user
      new_name = 'new name'
      patch :update, params: { id: user.id, user: { name: new_name } }
      expect(response).to have_http_status(302)
      expect(User.last.name).to eq(new_name)
    end
  end
end

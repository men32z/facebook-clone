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
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end

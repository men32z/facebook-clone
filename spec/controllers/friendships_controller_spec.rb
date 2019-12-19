# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  describe 'GET#index' do
    it 'returns http success' do
      user = User.create(user_valid)
      sign_in(user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST#create' do
    it 'creates a friendship request' do
      user = User.create(user_valid)
      sign_in user
      user2 = User.new(user_valid)
      user2.email = 'other@email.com'
      user2.save
      expect do
        post :create, params: { friend_id: user2.id }
        expect(response).to have_http_status(302)
      end.to change(Friendship, :count).by(2)
    end
  end

  describe 'PATCH#update' do
    it 'confirms a friendship request' do
      user = User.create(user_valid)
      user2 = User.new(user_valid)
      user2.email = 'other@email.com'
      user2.save
      sign_in user2
      friendship = Friendship.create(user_id: user.id, friend_id: user2.id)
      friendship_mirror = Friendship.where(user_id: friendship.friend_id, friend_id: friendship.user_id).first

      patch :update, params: { user_id: user.id, id: friendship_mirror.id }
      expect(response).to have_http_status(302)
      friendship.reload
      friendship_mirror.reload
      expect(friendship.confirmed).to eq(true)
      expect(friendship_mirror.confirmed).to eq(true)
    end
  end

  describe 'DELETE#destroy' do
    it 'removes a friend' do
      user = User.create(user_valid)
      sign_in user
      user2 = User.new(user_valid)
      user2.email = 'other@email.com'
      user2.save
      friendship = Friendship.create(user_id: user.id, friend_id: user2.id)
      delete :destroy, params: { user_id: user.id, id: friendship.id }
      expect(response).to have_http_status(302)
      expect(user.friends.count).to eq(0)
    end
  end
end

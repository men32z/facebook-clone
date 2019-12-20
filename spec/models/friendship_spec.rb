# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:valid_user) do
    has_x = { name: 'mike', email: 'mikew@monsterinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  it 'creates a friend request' do
    user = User.create(valid_user)
    user2 = User.new(valid_user)
    user2.email = 'other@email.com'
    user2.save
    expect do
      Friendship.create(user_id: user.id, friend_id: user2.id)
    end.to change(Friendship, :count).by(1)
  end

  it 'sender can\'t send another friend request to receiver.' do
    user = User.create(valid_user)
    user2 = User.new(valid_user)
    user2.email = 'other@email.com'
    user2.save
    expect do
      Friendship.create(user_id: user.id, friend_id: user2.id)
      Friendship.create(user_id: user.id, friend_id: user2.id)
    end.to change(Friendship, :count).by(1)
  end

  it 'reciever can\'t send a friend request to sender.' do
    user = User.create(valid_user)
    user2 = User.new(valid_user)
    user2.email = 'other@email.com'
    user2.save
    expect do
      Friendship.create(user_id: user.id, friend_id: user2.id)
      Friendship.create(user_id: user2.id, friend_id: user.id)
    end.to change(Friendship, :count).by(1)
  end

  it 'shows user and friend' do
    user = User.create(valid_user)
    user2 = User.new(valid_user)
    user2.email = 'other@email.com'
    user2.save
    friendship = Friendship.create(user_id: user.id, friend_id: user2.id)
    expect(friendship.user.id).to eq(user.id)
    expect(friendship.friend.id).to eq(user2.id)
  end
end

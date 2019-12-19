# frozen_string_literal: true

class Friendship < ApplicationRecord
  validate :users_are_not_already_friends, on: :create
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def users_are_not_already_friends
    reverse_friendship = Friendship.where(user_id: friend_id, friend_id: user_id).exists?
    reg_friendship = Friendship.where(user_id: user_id, friend_id: friend_id).exists?
    errors.add(:user_id, 'Already friends!') if reverse_friendship || reg_friendship
  end
end

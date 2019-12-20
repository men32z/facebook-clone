# frozen_string_literal: true

class Friendship < ApplicationRecord
  after_create :full_friends
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates :user_id, uniqueness: { scope: :friend_id, message: 'Already sent!' }

  private

  def confirm_full_friends
    mirror = Friendship.where(user_id: friend_id, friend_id: user_id).first
    return unless mirror && !mirror.confirmed

    mirror.confirmed = true
    mirror.save
  end

  def full_friends
    Friendship.create(user_id: friend_id, friend_id: user_id)
  end
end

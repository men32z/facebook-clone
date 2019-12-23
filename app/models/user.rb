# frozen_string_literal: true

class User < ApplicationRecord
  before_create :set_default_img
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 50, minimum: 2 }
  validates :email, length: { maximum: 255 }
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friendships.map(&:friend) & inverse_friendships.map(&:user)
  end

  def friends_ids
    friendships.map(&:friend_id) & inverse_friendships.map(&:user_id)
  end

  def related?(user)
    related = friendships.find { |friendship| friendship.friend == user }
    related || inverse_friendships.find { |friendship| friendship.user == user }
  end

  def pending_friends
    friendships.map(&:friend) - inverse_friendships.map(&:user)
  end

  def pending_friend?(user)
    pending_friends.find { |pending| pending == user }
  end

  def friend_request
    inverse_friendships.map(&:user) - friendships.map(&:friend)
  end

  def friend?(user)
    friends.include?(user)
  end

  private

  def set_default_img
    self.photo = '/default_profile.jpg'
  end
end

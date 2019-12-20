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
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def friends_ids
    friends_array = friendships.map { |friendship| friendship.friend.id if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user.id if friendship.confirmed }
    friends_array.compact
  end

  def related?(user)
    related = friendships.find { |friendship| friendship.friend == user }
    related || inverse_friendships.find { |friendship| friendship.user == user }
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def pending_friend?(user)
    pending_friends.find { |pending| pending == user }
  end

  def friend_request
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def friendship_id(user)
    friendship = Friendship.where(user_id: id, friend_id: user.id).first
    friendship ||= Friendship.where(user_id: user.id, friend_id: id).first
    friendship.id
  end

  private

  def set_default_img
    self.photo = '/default_profile.jpg'
  end
end

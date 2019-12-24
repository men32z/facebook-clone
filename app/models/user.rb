# frozen_string_literal: true

class User < ApplicationRecord
  before_create :set_default_img
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
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

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      user.photo = auth.info.image # assuming the user model has an image
    end
  end

  private

  def set_default_img
    self.photo = '/default_profile.jpg' if photo.nil?
  end
end

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

  private

  def set_default_img
    self.photo = '/default_profile.jpg'
  end
end

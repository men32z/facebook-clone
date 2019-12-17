# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, presence: true, length: { minimum: 1, maximum: 280 }
  belongs_to :user
  has_many :comments
  has_many :likes
end

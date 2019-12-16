# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, presence: true, length: { minimum: 1, maximum: 280 }
  belongs_to :user
end

class Comment < ApplicationRecord
  validates :content, presence: true, length: { minimum: 1, maximum: 140 }
  belongs_to :user
  belongs_to :post
end

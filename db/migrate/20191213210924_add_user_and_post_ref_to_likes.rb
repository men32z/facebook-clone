class AddUserAndPostRefToLikes < ActiveRecord::Migration[6.0]
  def change
    add_reference :likes, :user, null: false, foreign_key: true
    add_reference :likes, :post, null: false, foreign_key: true
  end
end

class RemoveConfirmedFromFriendships < ActiveRecord::Migration[6.0]
  def change
    remove_column :friendships, :confirmed, :boolean
  end
end

class AddUserIdToRooms < ActiveRecord::Migration
  def change
    add_column :users, :room_id, :integer
    remove_column :rooms, :user_id
  end
end

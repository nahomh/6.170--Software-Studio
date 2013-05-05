class AddBoardToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :whiteboard_available, :boolean
  end
end

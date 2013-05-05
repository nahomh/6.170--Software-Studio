class AddProjectorToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :projector_available, :boolean
  end
end

class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :description
      t.boolean :occupied
      t.float :latitude
      t.float :longitude
      t.integer :student_id
      t.string :room_number

      t.timestamps
    end
  end
end

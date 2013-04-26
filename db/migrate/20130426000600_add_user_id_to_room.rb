class AddUserIdToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :user_id, :integer
    remove_column :rooms, :student_id
    add_index :rooms, :user_id
  end
end

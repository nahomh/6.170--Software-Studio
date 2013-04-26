class Room < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :occupied, :room_number, :user_id, :name
  belongs_to :user

  def checkout(uid)
    update_attributes(:user_id => uid, :occupied => true)
  end

  def checkin
    update_attributes(:occupied => false)
    user.delete
  end
end

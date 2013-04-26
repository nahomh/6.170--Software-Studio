class Room < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => false
  attr_accessible :description, :latitude, :longitude, :occupied, :room_number, :user_id, :name
  belongs_to :user

  def checkout(uid)
    update_attributes(:user_id => uid, :occupied => true)
  end

  def checkin
    update_attributes(:occupied => false)
    user.delete
  end

  def gmaps4rails_address
    "#{latitude}, #{longitude}"
  end

end

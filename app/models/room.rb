class Room < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => false
  attr_accessible :description, :latitude, :longitude, :occupied, :room_number, :user_id, :name
  belongs_to :user

  def checkout(user_id)
    update_attributes(:user_id => user_id, :occupied => true)
  end

  def checkin
    update_attributes(:user_id => nil, :occupied => false)
  end

#Google Maps for Rails API Methods
  def gmaps4rails_address
    "#{latitude}, #{longitude}"
  end
  def gmaps4rails_infowindow
    "Room Name:#{name} <br>Room Number:#{room_number}<br>Occupied:#{occupied} <br> Descritption: #{description}"
  end
end

class Room < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => false
  attr_accessible :description, :latitude, :longitude, :occupied, :room_number, :user_id, :name, :projector_available, :whiteboard_available
  has_many :users

  def checkout
    if occupied
      return false
    else
      return update_attributes(:occupied => true)
    end
  end

  def checkin
    update_attributes(:occupied => false)
  end
  
  def self.search(q)
    if q
      if Rails.env.production?
        rooms = where("room_number ilike ?", "%#{q}%")
      else
        rooms = where("room_number like ?", "%#{q}%")
      end
    else
      rooms = scoped
    end
    return rooms
  end

#Google Maps for Rails API Methods
  def gmaps4rails_address
    "#{latitude}, #{longitude}"
  end
  def gmaps4rails_infowindow
    "Room Name:#{name} <br>Room Number:#{room_number}<br>Available:#{occupied} <br> Descritption: #{description}"
  end
end

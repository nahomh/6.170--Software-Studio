class Room < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => false
  attr_accessible :description, :latitude, :longitude, :occupied, :room_number, :user_id, :name, :projector_available, :whiteboard_available
  has_many :users
  
  #Methods
  #Requires: Room
  #Checks out a room if room is not occupied.
  def checkout
    if occupied
      return false
    else
      return update_attributes(:occupied => true)
    end
  end
  
  #Requires: Room
  #Checks if a room is currently busy/occupied.
  def self.return_busy
    rooms = where(:occupied => true).where("updated_at < ?", 2.hours.ago)
    rooms.each do |room|
      room.users.each do |user|
        user.checkin
      end
      room.checkin
    end
  end
  
  #Requires: Room
  #Checks in a room.
  def checkin
    update_attributes(:occupied => false)
  end
  
  #Requires: Room
  #Searchs for a room with a give room number.
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
  #Info window for google maps
  def gmaps4rails_infowindow
    if occupied
      "Room Name:#{name} <br>Room Number:#{room_number}<br>Status:Occupied<br> Description: #{description}"
    else
      "Room Name:#{name} <br>Room Number:#{room_number}<br>Status:Avaliable<br> Description: #{description}"
    end
  end
end


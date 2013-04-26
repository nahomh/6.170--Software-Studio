class Room < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :occupied, :room_number, :user_id, :name
end

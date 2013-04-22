class Room < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :occupied, :room_number, :student_id
end

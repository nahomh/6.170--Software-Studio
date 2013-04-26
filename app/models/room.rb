class Room < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => false
  attr_accessible :description, :latitude, :longitude, :occupied, :room_number, :student_id, :name


def gmaps4rails_address
  "#{latitude}, #{longitude}"
end

end

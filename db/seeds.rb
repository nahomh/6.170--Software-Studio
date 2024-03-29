# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
Room.create(:name => "Building 4 study room", :longitude => -71.090249, :latitude => 42.359844, :description => "Good classroom to study with friends or solo", :room_number => "4-321", :projector_available => true, :whiteboard_available => true)
Room.create(:name => "Reading Room", :longitude => -71.095, :latitude => 42.359, :description => "It's the reading room", :room_number => "reading room", :projector_available => false, :whiteboard_available => false)
Room.create(:name => "Eighth Floor Lounge", :longitude => -71.09056786, :latitude => 42.3641081517695, :description => "Nice place to take a nap", :room_number => "z-823", :projector_available => false, :whiteboard_available => true)

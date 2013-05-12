class User < ActiveRecord::Base
  include Math
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :room_id, :longitude, :latitude
  belongs_to :room

  #Methods
  #Authentication via Omniauth
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      puts auth
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.email = auth.info.email
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
 #Requires:longitude, latitude
 #Updates the current user's location
  def update_location(longitude, latitude)
    self.longitude = longitude
    self.latitude = latitude
    self.save
  end

  #Requires: user, room_id
  #Updates checkin for a user into a particular room.
  def checkin
    update_attributes(:room_id => nil)
  end

  #Requires: user, room_id
  #Updates:  Checks out a specific user from a room. 
  def checkout(room_id)
    update_attributes(:room_id => room_id)
  end
  
  #Requires: Graph
  #Gets the user's facebook friends.
  def get_fb_friends(graph)
    friends = graph.get_connections("me", "friends")
    return friends
  end

  #Requires:friend_id, graph
  #Checks the user's facebook friends for a friends on MITSpaces.
  def facebook_friends? (friend_id, graph)
    fb_friends = get_fb_friends(graph)
    friend_fbids = fb_friends.map{|friend| friend["id"]}
    return friend_fbids.include?(User.find(friend_id).uid)
  end
  #Requires: graph
  #Gets friend_ids for the user's facebook friends
  def friend_ids(graph)
    fb_friends = get_fb_friends(graph)
    friend_fbids = fb_friends.map{|friend| friend["id"]}
    friends = User.where(:uid => friend_fbids)
    friend_ids = friends.map{|friend| friend.id}
    return friend_ids
  end
 
  #Requires: graph
  #Gets the uses where their ids are in the friends graph ids.
  def friends(graph)
    friends = User.where(:id => friend_ids(graph))
  end
  #Haversine formula to calculate distance between two coordinates
  #if the user does not have a location (in the case of browswer issues), 
  #we give the user the benefit of the doubt and allows them to checkin anywhere
  #Requires: room
  #Checks if the user's coordinates are close enough to a room's location
  def close_to_room(room)
    if self.latitude == nil && self.longitude == nil
      d = 0
    else
      d=50000
      if self.latitude && self.longitude
        r = 6371
        rad = Math::PI/180
        dLat = (self.latitude - room.latitude)*rad
        dLong = (self.longitude - room.longitude)*rad
        lat1 = self.latitude*rad
        lat2 = room.latitude*rad
        a = Math.sin(dLat/2)*Math.sin(dLat/2)+ Math.cos(lat1)*Math.cos(lat2)*Math.sin(dLong/2)*Math.sin(dLong/2)
        c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
        d = r * c 
      end
    end
    return d
  end  
end

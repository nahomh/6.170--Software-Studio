class User < ActiveRecord::Base
  include Math
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :room_id, :longitude, :latitude
  belongs_to :room
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.email = auth.info.email
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  def update_location(longitude, latitude)
    self.longitude = longitude
    self.latitude = latitude
    self.save
  end
  def checkin
    update_attributes(:room_id => nil)
  end

  def checkout(room_id)
    update_attributes(:room_id => room_id)
  end

  def get_fb_friends(graph)
    friends = graph.get_connections("me", "friends")
    return friends
  end

  def facebook_friends? (friend_id, graph)
    fb_friends = get_fb_friends(graph)
    friend_fbids = fb_friends.map{|friend| friend["id"]}
    return friend_fbids.include?(User.find(friend_id).uid)
  end

  def friend_ids(graph)
    fb_friends = get_fb_friends(graph)
    friend_fbids = fb_friends.map{|friend| friend["id"]}
    friends = User.where(:uid => friend_fbids)
    friend_ids = friends.map{|friend| friend.id}
    return friend_ids
  end

  def friends(graph)
    friends = friend_ids(graph)
    friends.map{ |friend| User.find(friend) }
  end
  #haversine formula to calculate distance between two coordinates
  def close_to_room(room)
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
    return d
  end  
end

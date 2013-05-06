OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['secret']
end


#Enabling mock data for unit tests
OmniAuth.config.test_mode = true

raw_info = Hashie::Mash.new
raw_info.email = "yourname@email.com"
raw_info.first_name = "fname"
raw_info.gender = "female"
raw_info.id = "123456"
raw_info.last_name ="lname"
raw_info.link = "http://www.facebook.com/url&#8220;"
raw_info.locale = "en_US"
raw_info.name = "fname lname"
raw_info.timezone = 5.5
raw_info.updated_time = "2013-05-04T13:09:47+0000"
raw_info.username = "fname.lname"
raw_info.verified = true

extra_info = Hashie::Mash.new

extra_info.raw_info = raw_info

info = OmniAuth::AuthHash::InfoHash.new

info.first_name = "fname"
info.image = "http://graph.facebook.com/123456/picture?type=square&#8221;"
info.last_name = "lname"
info.location = "location,state,country"
info.name = "fname lname"
info.nickname = "fname.lname"
info.verified = true

auth_hash = OmniAuth::AuthHash.new
auth_hash.provider = 'facebook'
auth_hash.uid = '123456'
auth_hash.info = info

OmniAuth.config.mock_auth[:facebook] = auth_hash

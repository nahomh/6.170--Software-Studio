$ ->
  
  $(".map_container").ready getlocation
  
 
#Requires:None
#Gets the current location of the user.
          
getlocation = (event) ->
  console.log(navigator.geolocation)
  if navigator.geolocation
      navigator.geolocation.getCurrentPosition(showPosition,errorPosition, {timeout:3000})
  
  console.log('talkjfafs')

#Requires:None
#Handling case when user location data can't be captured.
errorPosition = (position) =>
  user = $(".user")
  console.log("could not capture date")
  $("#demo").append("latitude:"+"nil"+'<br>'+
    "longitude:"+"nil")
  $.ajax
    url: user[0]+'/set_location'
    data: {latitude: null, longitude: null}
    dataType: "script"
    type: "PUT"
    complete: (data) ->
      new_room = $("<div></div>")
      new_room.append(data.responseText)


#Requires: None
#Ajax call to set user's location.
showPosition = (position) ->

  console.log(position)
  user = $(".user")
  console.log(position.coords.latitude)
  console.log(position.coords.longitude)
  $("#demo").append("latitude:"+position.coords.latitude+'<br>'+
    "longitude:"+position.coords.longitude)
  $.ajax #Calls the set_location method in the controller with a specific user id.
    url: user[0]+'/set_location'
    data: {latitude: position.coords.latitude, longitude: position.coords.longitude}
    dataType: "script"
    type: "PUT"
    complete: (data) ->
      new_room = $("<div></div>")
      new_room.append(data.responseText)


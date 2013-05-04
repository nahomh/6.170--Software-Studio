$ ->

 
  $(".map_container").ready getlocation
  
 
          
getlocation = (event) ->
  if navigator.geolocation
      navigator.geolocation.getCurrentPosition(showPosition, errorPosition, {timeout:10000})
  
  console.log('talkjfafs')
errorPosition = (position) =>
  console.log("could not capture date")
showPosition = (position) ->
  user = $(".user")
  console.log(position.coords.latitude)
  console.log(position.coords.longitude)
  $("#demo").html("latitude:"+position.coords.latitude+'<br>'+
    "longitude:"+position.coords.longitude)
  $.ajax
    url: user[0]+'/set_location'
    data: {latitude: position.coords.latitude, longitude: position.coords.longitude}
    dataType: "script"
    type: "PUT"
    complete: (data) ->
      new_room = $("<div></div>")
      new_room.append(data.responseText)








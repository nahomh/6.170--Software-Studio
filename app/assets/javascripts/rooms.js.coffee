$ ->
  $("#try").click getlocation
  
 
          
getlocation = (event) ->
  if navigator.geolocation
      navigator.geolocation.getCurrentPosition(showPosition)

  
  console.log('talkjfafs')
  
showPosition = (position) ->
  console.log(position.coords.latitude)
  console.log(position.coords.longitude)
  $("#demo").html("latitude:"+position.coords.latitude+'<br>'+
    "longitude:"+position.coords.longitude)
  $.ajax
    url: '1/new_location'
    data: {latitude: position.coords.latitude, longitude: position.coords.longitude}
    dataType: "script"
    type: "GET"








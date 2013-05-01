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
    url: '/rooms/1/location'
    data: {latitude: position.coords.latitude, longitude: position.coords.longitude}
    dataType: "script"
    type: "GET"
    complete: (data)->
      alert("this wis workigns sorta")









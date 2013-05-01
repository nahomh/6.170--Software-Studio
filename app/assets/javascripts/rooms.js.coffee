$ ->
  $(".checkout").click getlocation
  $("#try").click getlocation
  
 
          
getlocation = (event) ->
  $.ajax
    url: '1/location'
    data: null
    dataType: "script"
    type: "GET"
    complete: ->
      alert("this wis workigns sorta")
  console.log('talkjfafs')
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(showPosition)
showPosition = (position) ->
  console.log(position.coords.latitude)
  console.log(position.coords.longitude)








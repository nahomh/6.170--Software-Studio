# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  setInterval refresh_roous, 9000
  
refresh_rooms = (event) ->
  rooms = $(".room")
  rooms.each ->
    room = $(this)
    $.ajax
      url: "/rooms/"+room[0]['id']+"/refresh"
      data: null
      dataType: "script"
      type: "GET"
      complete: (data) ->
        new_room = $("<div></div>")
        new_room.append(data.responseText)
        room_parent = room.parent()
        room_parent.append(new_room)
        room.remove()

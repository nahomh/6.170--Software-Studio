# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#game_user_tokens').tokenInput('/users.json', {
    crossDomain: false,
    onAdd: friend_handler,
    hintText: "Type in a friend's name",
    tokenFormatter: (item) ->
      return "<li>" + "<img src='" + item.url + "' title='" + item.name + "' height='25px' width='25px' />" + "<div style='display: inline-block; padding-left: 10px;'><div class='name'>" + item.name + "</div></div></li>"
    ,
    resultsFormatter: (item) ->
      return "<li>" + "<img src='" + item.url + "' title='" + item.name + "' height='25px' width='25px' />" + "<div style='display: inline-block; padding-left: 10px;'><div class='name'>" + item.name + "</div></div></li>"
  });

  setInterval refresh_rooms, 9000
  
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

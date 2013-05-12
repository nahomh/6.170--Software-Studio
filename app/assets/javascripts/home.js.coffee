# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  setInterval refresh_rooms, 15000
  $(".occupied-color").click relocation_handler
  $(".rooms-table th a, .rooms-table .pagination a, .rooms-table .rooms-options a").click sort_handler
  $(".rooms-search").submit search_handler

search_handler = (event) ->
  old_table_parent = $(".rooms-table")
  $.ajax
    url: $(this).attr("action")
    data: $(this).serialize()
    dataType: "script"
    method: "GET"
    complete: (data) ->
      new_table = $(data.responseText)
      old_table_parent.children().remove()
      old_table_parent.append(new_table)
      $(".occupied-color").click relocation_handler
      $(".rooms-table th a, .rooms-table .pagination a, .rooms-table .rooms-options a").click sort_handler
      map_handler()
  return false

refresh_friends = (event) ->
  friend_parent = $(".friends-list-sidebar")
  $.ajax
    url: "/users/friends"
    data: null
    dataType: "script"
    method: "GET"
    complete: (data) ->
      new_friends = $(data.responseText)
      friend_parent.children().remove()
      friend_parent.append(new_friends)

  

sort_handler = (event) ->
  old_table_parent = $(".rooms-table")
  $.ajax
    url: $(this).attr('href')
    data: null
    dataType: "script"
    method: "GET"
    complete: (data) ->
      new_table = $(data.responseText)
      old_table_parent.children().remove()
      old_table_parent.append(new_table)
      $(".occupied-color").click relocation_handler
      $(".rooms-table th a, .rooms-table .pagination a, .rooms-table .rooms-options a").click sort_handler
      map_handler()
  return false
     
#Requires:None
#Ajax call to update the status of each room in the rooms table, changing the respective row of each room to reflect the status of the specfic room.
relocation_handler = (event) ->
  room = $(this)
  document.location.href="/rooms/"+room[0]['id']
  
refresh_rooms = (event) ->
  rooms = $(".occupied-color")
  rooms.each ->
    room = $(this) #selects the row of each room, requiring the id of that row to be the id of the room. 
    $.ajax #Call to the controller refresh method with a given room id.
      url: "/rooms/"+room[0]['id']+"/refresh"
      data: null
      dataType: "json"
      type: "GET"
      complete: (data) -> #After call is completed re-render by changing or keeping the current class associated with the row in the table to reflect the status of the current room.
        new_room = JSON.parse(data.responseText)
        change_text = room.find(".occupied-text")
        if new_room.occupied
          room.removeClass("success error")
          room.addClass("error")
          change_text.html("Unavailable")
        else
          room.removeClass("error success")
          room.addClass("success")
          change_text.html("Available")
  map_handler()
  refresh_friends()

#Requires:None
#Ajax call to update the status of each room in the map, and changes the respective status of each to reflect their current status.
map_handler = (event) ->
  $.ajax
    url: $("#map-refresh").attr('href')
    data: null
    dataType: "json"
    type: "GET"
    complete: (data) ->
      map_data = JSON.parse(data.responseText)
      Gmaps.loadMaps()
      Gmaps.map.clearMarkers()
      Gmaps.map.addMarkers(map_data)
  return false

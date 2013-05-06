# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  setInterval refresh_rooms, 5000
  $(".occupied-color").click relocation_handler
  $(".rooms-table th a, .rooms-table .pagination a").click sort_handler
  $(".rooms-search").submit search_handler

search_handler = (event) ->
  old_table_parent = $(".rooms-table")
  old_table = old_table_parent.find("table")
  console.log(JSON.stringify($(this).serialize()))
  $.ajax
    url: $(this).attr("action")
    data: $(this).serialize()
    dataType: "script"
    method: "GET"
    complete: (data) ->
      new_table = $(data.responseText)
      console.log(new_table)
      old_table_parent.children().remove()
      old_table_parent.append(new_table)
      $(".occupied-color").click relocation_handler
      $(".rooms-table th a").click sort_handler
  return false

sort_handler = (event) ->
  old_table_parent = $(".rooms-table")
  old_table = old_table_parent.find("table")
  $.ajax
    url: $(this).attr('href')
    data: null
    dataType: "script"
    method: "GET"
    complete: (data) ->
      new_table = $(data.responseText)
      old_table.remove()
      old_table_parent.append(new_table)
      $(".occupied-color").click relocation_handler
      $(".rooms-table th a").click sort_handler
  return false
     

relocation_handler = (event) ->
  room = $(this)
  document.location.href="/rooms/"+room[0]['id']
  console.log(room[0])
  
refresh_rooms = (event) ->
  rooms = $(".occupied-color")
  rooms.each ->
    room = $(this)
    $.ajax
      url: "/rooms/"+room[0]['id']+"/refresh"
      data: null
      dataType: "json"
      type: "GET"
      complete: (data) ->
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

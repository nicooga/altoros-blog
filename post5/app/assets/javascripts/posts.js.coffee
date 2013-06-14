# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.post a.vote_up').click (ev)->
    ev.stopImmediatePropagation()
    ev.preventDefault()
    id = @id
    $.ajax
      url: "/posts/#{id}/vote_up.json",
      type: 'POST',
      complete: (data)->
        post = JSON.parse(data.responseText)
        $("small##{id}_votes").text("Votes: #{post.votes}")
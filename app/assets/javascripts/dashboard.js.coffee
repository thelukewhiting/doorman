# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
# Activates button selection for Bootstrap JS
  $('.btn').button()

  handle_mode_click = (button_id) ->
    $("#" + "#{button_id}").on 'click', (event) ->
      event.preventDefault()
      $.get( '/settings/update_mode', {mode: button_id}).done (data) ->
        $('.col-md-9').empty().append(JST["templates/" + "#{button_id}"](settings: data[0]))

  handle_mode_click 'manual'

  handle_mode_click 'autounlock'

  handle_mode_click 'pinunlock'

  handle_mode_click 'forward'

  $('body').on 'click', 'button[class="btn btn-primary cancel-timer"]', (event) ->
    event.preventDefault()
    $('.col-md-9').empty().append(JST["templates/autounlock"])
    $.get( '/settings/update_mode', {mode: 'autounlock'})

  $('body').on 'click', 'li[class="time"]', (event) ->
    event.preventDefault()

    $('button[class="btn btn-default time-dropdown"]').text($(this).text())
    seconds = $(this).data('seconds')

    $('button[class="btn btn-primary start-timer"]').on 'click', (event) ->
      event.preventDefault

      $.get( '/settings/start_timer', {seconds: seconds}).done (data) ->
        $('.col-md-9').empty().append(JST["templates/autounlock_timer"](countdown: data.countdown))
        # console.log data.countdown

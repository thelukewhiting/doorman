# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  createTwilioAccount = ->

    $.get '/settings/create_twilio_account', (data) ->
      console.log data
    , 'json'

  $('.start').on 'click', (event) ->
    event.preventDefault()

    createTwilioAccount()

    $('.new-setting-flow').empty()
    $('.new-setting-flow').append(JST["templates/area_code"])

  $('body').on 'click', 'button[class="btn btn-primary btn-lg find-numbers"]', (event) ->
    event.preventDefault()

    $(this).text('Loading...')

    area_code = $(this).prev().val()

    $.get( '/settings/fetch_twilio_number', {area_code: area_code}).done (data) ->
        console.log data
        $('.new-setting-flow').empty()
        $('.new-setting-flow').append(JST["templates/twilio_numbers"](numbers: data))

  $('body').on 'click', 'li[class="number"]', (event) ->
    event.preventDefault()

    number = $(this).children().text()

    console.log number

    $.get( '/settings/buy_twilio_number', {phone_number: number}).done (data) ->
        console.log data

        $('.new-setting-flow').empty()
        $('.new-setting-flow').append(JST["templates/number_success"](number: data))

  $('body').on 'click', 'button[class="btn btn-primary btn-lg next-settings"]', (event) ->
    event.preventDefault()

    $('.new-setting-flow').empty()
    $('.new-setting-flow').append(JST["templates/settings"])

  $('body').on 'click', 'button[class="btn btn-default save-settings"]', (event) ->
    event.preventDefault()

    $.post( "/settings", $('#settings_form').serialize() ).done (data) ->
        console.log data
        $('.new-setting-flow').empty()
        $('.new-setting-flow').append(JST["templates/test_settings"])

  $('body').on 'click', 'button[class="btn btn-primary btn-lg test-settings"]', (event) ->
    event.preventDefault()

    $.get '/settings/test_settings'













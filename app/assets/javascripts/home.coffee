# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

formatDate = (d) ->
  result = d.match(/([0-9]+)-([0-9]+)-([0-9]+)T([0-9]+):([0-9]+):([0-9]+)([\+-])([0-9]+):([0-9]+)/)
  if (result.length < 10)
    return "?"
  y = result[1]
  month = result[2]
  d = result[3]
  h = result[4]
  m = result[5]
  s = result[6]
  tz_sign = result[7]
  tz_h = result[8]
  tz_m = result[9]

  return "#{y}/#{month}/#{d} #{h}:#{m} UTC#{tz_sign}#{tz_h}:#{tz_m}"


formatLength = (l) ->
  h = Math.floor(l / 60)
  m = l - 60*h
  return "#{h}:#{m}"





prepareFlight = (f) ->
  div = $(".flight#dummy").clone(true).first()
  console.log f
  $(div).attr('id', f["key"])
  $(div).find(".flight-airline").text(f["airline"]["name"])
  $(div).find(".flight-start").text(formatDate f["start"]["dateTime"])
  $(div).find(".flight-length").text(formatLength f["durationMin"])
  $(div).find(".flight-end").text(formatDate f["finish"]["dateTime"])
  $(div).find(".flight-price").text("$" + f["price"])
  $(div).find(".flight-plane-model").text(f["plane"]["shortName"])
  return div



$(document).ready ->
  $(".no-flights-found").hide()
  $(".loading-please-wait").hide()
  $(".search_button").click (e)->
    e.preventDefault()
    console.log("Hi")
    t = e.target

    formId = $(t).attr("data-form-id")
    console.log formId
    wrapper = $("#wrapper_#{formId}")
    form = $(wrapper).find(".search_form")
    url = form.attr("action")
    flights = $(wrapper).find(".flights")

    from = $(form).find("#from").val()
    to = $(form).find("#to").val()
    date = $(form).find("#date").val()

    $.getJSON url, {from: from, to: to, date: date}
      .done (obj) ->
        console.log(obj)
        if obj.length == 0
          $(wrapper).find(".no-flights-found").show()
          $(wrapper).find(".loading-please-wait").hide()
        for f in obj
          $(wrapper).find(".no-flights-found").hide()
          $(wrapper).find(".loading-please-wait").hide()
          div = prepareFlight f
          $(flights).append(div)
      .fail (obj) ->
          console.log(obj)
          $(wrapper).find(".no-flights-found").show()
          $(wrapper).find(".loading-please-wait").hide()
    
    $(wrapper).find(".no-flights-found").hide()
    $(wrapper).find(".loading-please-wait").show()



    return false







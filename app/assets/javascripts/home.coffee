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

  return "#{d}/#{month} #{h}:#{m} UTC#{tz_sign}#{tz_h}:#{tz_m}"

formatLength = (l) ->
  h = Math.floor(l / 60)
  m = String(l - 60*h)
  h = String(h)
  while (h.length < 2)
    h = "0" + h
  while (m.lengtm < 2)
    m = "0" + m
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

processSearchButton = (e)->
    e.preventDefault()
    t = e.target

    formId = $(t).attr("data-form-id")
    wrapper = $("#wrapper_#{formId}")
    form = $(wrapper).find(".search_form")
    url = form.attr("action")
    flights = $(wrapper).find(".flights")

    from = $(form).find("#from").val()
    to = $(form).find("#to").val()
    date = $(form).find("#date").val()

    if (!from.length || !to.length || !date.length)
      $(wrapper).find(".no-flights-found").hide()
      $(wrapper).find(".loading-please-wait").hide()
      $(wrapper).find(".wrong-input").show()
      return

    $.getJSON url, {from: from, to: to, date: date}
      .done (obj) ->
        if obj.length == 0
          $(wrapper).find(".wrong-input").hide()
          $(wrapper).find(".no-flights-found").show()
          $(wrapper).find(".loading-please-wait").hide()
        for f in obj
          $(wrapper).find(".wrong-input").hide()
          $(wrapper).find(".no-flights-found").hide()
          $(wrapper).find(".loading-please-wait").hide()
          div = prepareFlight f
          $(flights).append(div)
      .fail (obj) ->
          $(wrapper).find(".wrong-input").hide()
          $(wrapper).find(".no-flights-found").show()
          $(wrapper).find(".loading-please-wait").hide()
    
    $(wrapper).find(".wrong-input").hide()
    $(wrapper).find(".no-flights-found").hide()
    $(wrapper).find(".loading-please-wait").show()
    return false

loadAirports = (q, callback) ->
  
  if (q.length < 3)
    return callback([])

  $.getJSON("airports", {query: q})
    .fail ->
      callback()
    .done (res) ->
      callback(res.slice(0,10))


  return true

renderAirport = (item, escape) ->
  a = $("<div class='airport'></div>")
  $(a).append("<div class='code'>" + item.code + "</div>")
  $(a).append("<div class='name'>" + item.name + "</div>")
  $(a).append("<div class='cityName'>" + item.cityName + "</div>")
  return $(a)

$(document).ready ->
  $(".no-flights-found").hide()
  $(".loading-please-wait").hide()
  $(".wrong-input").hide()
  $(".search_button").click processSearchButton
  $(".airport_search_field").each (i, f) ->
    $(f).selectize({
      options: [],
      create: false,
      load: (q, c) ->
        loadAirports(q,c)
      render: {option: renderAirport},
      valueField: "code",
      labelField: "name",
      searchField: ["name", "code", "cityName"],
      persist: false,
      selectOnTab: true,
      onChange: (v) ->
        $(f).
        console.log(v)

    })

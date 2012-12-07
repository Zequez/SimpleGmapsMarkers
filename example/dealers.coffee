class DealersMap
  constructor: (@e)->
    @dealers = JSON.parse(@e.attr('data-dealers'))
    @build_gmap()
    @build_markers()
    @fit_map()

  build_gmap: ->
    @gmap = new google.maps.Map @e[0], @gmap_options()

  gmap_options: ->
    {
      center: @position(),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      zoom: 8,
    }

  position: ->
    @latlng or= new google.maps.LatLng(@dealers[0].lat, @dealers[0].lng)

  build_markers: ->
    @markers = []
    for dealer in @dealers
      @markers.push new DealerMarker(dealer, @gmap, (=> @close_windows()))

  fit_map: ->
    bounds = new google.maps.LatLngBounds
    for marker in @markers
      bounds = bounds.extend marker.latlng()
    @gmap.fitBounds bounds

  close_windows: ->
    marker.close_window() for marker in @markers

class DealerMarker
  constructor: (@data, @gmap, @open_window_callback)->
    @build_marker()
    @bind_marker()
    @bind_dom_element()

  build_marker: ->
    @marker = new google.maps.Marker @marker_options()

  marker_options: ->
    {
      map: @gmap
      position: @latlng()
      icon: DealerMarker.icon()
    }

  bind_marker: ->
    google.maps.event.addListener @marker, 'click', =>
      @open_window()

  bind_dom_element: ->
    e = document.getElementById("dealer-#{@data.id}")
    if e
      e = $(e)
      e.click =>
        @open_window()

  open_window: ->
    @open_window_callback()
    if @info_window
      @info_window.open @gmap
    else
      @build_info_window()

    if @gmap.getZoom() < 9
      @gmap.setZoom(12)

  close_window: ->
    if @info_window
      @info_window.close()

  build_info_window: ->
    @info_window = new google.maps.InfoWindow @info_window_options()

  info_window_options: ->
    {
      map: @gmap
      position: @latlng()
      content: @info_window_content()
      maxWidth: 150
    }

  info_window_content: ->
    content = "<div class='dealer-map-info'>"
    content += "<strong>#{@data.name}</strong><br/>"
    content +="#{@data.address}<br/>"
    content +="</div>"

  latlng: ->
    @_latlng or= new google.maps.LatLng(@data.lat, @data.lng)

  @icon: ->
    @_icon or= new google.maps.MarkerImage('assets/store.png')

class DealerInfoWindow
  constructor: (@data)->


class DealersList
  constructor: (@e)->
    @find_elements()
    @bind_countries()
    @bind_cities()
    @bind_dealers()

  find_elements: ->
    @dealers_countries = $('.dealers-countries li')
    @dealers_cities = $('.dealers-cities li')
    @dealers = $('.dealers li')
    @title_city = $('#dealers-current-city')
    @title_country = $('#dealers-current-country')

  bind_countries: ->
    _this = this
    @dealers_countries.click -> _this.select_country($(this))

  bind_cities: ->
    _this = this
    @dealers_cities.click -> _this.select_city($(this))

  bind_dealers: ->
    @dealers.click ->
      window.location.hash = ''
      window.location.hash = 'dealers-map'

  select_country: (e)->
    @dealers_countries.removeClass('active')
    e.addClass('active')

    @title_country.text e.text()

    country_id = e.attr('data-country')
    country_cities = @dealers_cities.filter("[data-country='#{country_id}']")

    @dealers_cities.filter(':visible').fadeOut =>
      country_cities.fadeIn()

    @select_city(country_cities.first())

  select_city: (e)->
    @dealers_cities.removeClass('active')
    e.addClass('active')

    @title_city.text e.text()

    city_id = e.attr('data-city')
    city_dealers = @dealers.filter("[data-city='#{city_id}']")

    @dealers.filter(':visible').fadeOut =>
      city_dealers.fadeIn()



$ = jQuery
$ ->
  dealers_map = $('#dealers-map')
  if dealers_map.length > 0
    new DealersMap(dealers_map)

  dealers_list = $('.dealers-list')
  if dealers_list.length > 0
    new DealersList(dealers_list)
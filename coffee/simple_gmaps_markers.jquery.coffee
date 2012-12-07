$ = jQuery;

class SimpleGmapsMarker
  constructor: (@element, @options)->
    @findElements()
    @buildGmap()
    @buildMarkers()
    @fitMap()


  findElements: ->
    @element = $(@element)
    @markers_elements = @element.find('.simple-gmaps-marker').remove()

  buildMarkers: ->
    @markers = for marker_element in @markers_elements
      marker = new Marker($(marker_element), @gmap)
      do (marker)=>
        marker.onClick =>
          (mark.deactivate() if mark != marker) for mark in @markers
          marker.toggle()
      marker


  buildGmap: ->
    @gmap = new google.maps.Map @element[0], @gmapOptions()

  gmapOptions: ->
    {
      center: new google.maps.LatLng(0, 0),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      zoom: 8,
    }

  bounds: ->
    @_bounds or= do =>
      bounds = new google.maps.LatLngBounds
      for marker in @markers
        bounds = bounds.extend marker.latlng()
      bounds

  fitMap: ->
    @gmap.fitBounds @bounds()
    console.log @gmap.getZoom()
    listener = google.maps.event.addListener @gmap, "idle", =>
      @gmap.setZoom(14) if @gmap.getZoom() > 14
      google.maps.event.removeListener(listener)

class Marker
  constructor: (@element, @gmap)->
    @buildMarker()
    @buildInfobox()
    @bindInfobox()

  onClick: (@callbackClick)->

  buildMarker: ->
    @marker = new google.maps.Marker @markerOptions()

  markerOptions: ->
    {
      map: @gmap
      position: @latlng()
      icon: new google.maps.MarkerImage('1x1t.gif')
    }

  latlng: -> @_latlng or= new google.maps.LatLng @lat(), @lng()
  lat: -> parseFloat @element.attr('data-lat')
  lng: -> parseFloat @element.attr('data-lng')

  buildInfobox: ->
    @infobox = new InfoBox @infoboxOptions()
    @infobox.open @gmap, @marker

  infoboxOptions: ->
    {
      content: @element[0],
      closeBoxURL: '',
      alignBottom: true,
    }

  bindInfobox: ->
    google.maps.event.addDomListener @element[0], 'click', =>
      @callbackClick() if @callbackClick

  activate: ->
    @element.addClass 'active'

  deactivate: ->
    @element.removeClass 'active'

  toggle: ->
    if @element.hasClass 'active'
      @deactivate()
    else
      @activate()


$.fn.extend
  simpleGmapsMarker: (options)->
    this.each ->
      $(this).data 'simpleGmapsMarker', new SimpleGmapsMarker(this, options);

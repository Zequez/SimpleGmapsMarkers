#= require infobox_packed

$ = jQuery;

class SimpleGmapsMarkers
  constructor: (@element, @options)->
    @findElements()
    @buildGmap()
    @buildMarkers()
    @fitMap()


  findElements: ->
    @element = $(@element)
    @markers_elements = @element.find('[data-lat]').remove()

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
    listener = google.maps.event.addListener @gmap, "idle", =>
      @gmap.setZoom(14) if @gmap.getZoom() > 14
      google.maps.event.removeListener(listener)

class Marker
  constructor: (@element, @gmap)->
    @buildInfobox()
    @bindInfobox()

  onClick: (@callbackClick)->

  latlng: -> @_latlng or= new google.maps.LatLng @lat(), @lng()
  lat: -> parseFloat @element.attr('data-lat')
  lng: -> parseFloat @element.attr('data-lng')

  buildInfobox: ->
    @infobox = new InfoBox @infoboxOptions()
    @infobox.open @gmap #, @marker

  infoboxOptions: ->
    {
      content: @element[0],
      closeBoxURL: '',
      alignBottom: true,
      isHidden: false,
      pane: 'floatPane',
      position: @latlng(),
      enableEventPropagation: false
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
  simpleGmapsMarkers: (options)->
    this.each ->
      $(this).data 'simpleGmapsMarkers', new SimpleGmapsMarkers(this, options);

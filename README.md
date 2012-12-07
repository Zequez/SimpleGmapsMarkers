# Simple Gmaps Markers

Simple Gmaps Markers is a little useful library to create map with a custom
marker and label without having to write a single line of JavaScript.

This is a heavily used feature that often is done by using the default iframe
that gives you an ugly "A" marker with a big white and ugly label.

If you are more of an action person, you can check the example on the /example folder.

## Setting up

First, we *do need* to include the Google Maps API, to do this, include
the following script on the webpage:

```html
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
```

If you are already running jQuery then you can use the autorun library:

```html
<script type="text/javascript" src="/path/to/google_maps_marker.jquery.autorun.min.js"></script>
```

If not, you have to execute Simple Gmaps Markers manually:

```html
<script type="text/javascript" src="/path/to/google_maps_marker.min.js"></script>
<script type="text/javascript">
  var onload = function(){
    new SimpleGmapsMarkers('simple-gmaps', {});
  };
</script>
```

## The HTML tag

Then include the following HTML in any part of your website:

```html
<div class="simple-gmaps">
  <div class="simple-gmaps-label" data-lat="-37.123123" data-lng="-58.4324234">
    Whatever you want to say then they click the marker.
  </div>
  <div class="simple-gmaps-marker"></div>
</div>
```

`data-lat` and `data-lng` are the latitude and longitude where the map marker is being set.
To find out these values just head to http://maps.google.com and press SHIFT while hovering over any
part of the map.

Then you just need to style the `simple-gmaps-label` and `simple-gmaps-marker` classes with CSS.

There is just one rule to style the `simple-gmaps-marker`, you must set the `background-image`.
Then you can also add optionals:

  * `height` (default 37px)
  * `width` (default 32px)
  * `margin-top` (default -37px)
  * `margin-left` (default -17px)

*Remember: the CSS of the marker is just to pass information,
the actual marker won't have the CSS class or any other property*

## Multiple markers

```html
<div class="simple-gmaps">
  <div class="simple-gmaps-label" data-lat="-37.123123" data-lng="-58.4324234">
    Something
  </div>
  <div class="simple-gmaps-label" data-lat="-37.123123" data-lng="-58.4324234" data-marker="red-marker">
    Something else
  </div>
  <div class="simple-gmaps-label" data-lat="-37.123123" data-lng="-58.4324234" data-marker="red-marker">
    Another something
  </div>
  <div class="simple-gmaps-marker blue-marker"></div>
  <div class="simple-gmaps-marker red-marker"></div>
</div>
```

It's pretty much self-explanatory, you add multiple `simple-gmaps-marker` and multiple
`simple-gmaps-label`.

`simple-gmaps-marker` takes the attribute `data-marker`, this is read as a class
and makes it use the `simple-gmaps-marker` with such class. If no `data-marker` is
given, it just uses the first `simple-gmaps-marker`.

## Autorun or manual

If you have jQuery already loaded and you want to do it as simple as possible,
without writing JavaScript, just include the autorun script:

```html
<script type="text/javascript" src="/path/to/google_maps_marker.jquery.autorun.min.js"></script>
```

Doing that is the same as:

```html
<script type="text/javascript" src="/path/to/google_maps_marker.min.js"></script>
<script type="text/javascript">
  jQuery(function(){
    new SimpleGmapsMarkers('simple-gmaps', {});
  });
</script>
```

`{}` doesn't hold any option yet, but it could in the future.

If you wanted to load it manually there are 2 ways:

The JavaScript way:

```javascript
  new SimpleGmapsMarkers('simple-gmaps', {});

  # Or you can also

  new SimpleGmapsMarker(document.getElementsByClassName('simple-gmaps', {}));

  # And because those are defaults, it's the same as:

  new SimpleGmapsMarker();
```

And the jQuery way:

```javascript
  $('.simple-gmaps').simpleGmapsMarkers({});
```

## Things to keep in mind

Remember that all `simple-gmaps-label` and `simple-gmaps-marker` elements are
removed from the DOM when the script loads.




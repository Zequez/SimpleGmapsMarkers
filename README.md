# Simple Gmaps Markers

Simple Gmaps Markers is a little useful library to create map with a custom
marker and label without having to write a single line of JavaScript.

This is a heavily used feature that often is done by using the default iframe
that gives you an ugly "A" marker with a big white, ugly and uncostumizable label.

If you are more of an action person, you can check the example on the /example folder.

## Setting up

First, we *do need* to include the Google Maps v3 API, to do this, include
the following script within the head tag:

```html
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
```

Then you just have to include the SimpleGmapsMarkers library:

```html
<script type="text/javascript" src="/path/to/google_maps_marker.jquery.autorun.min.js"></script>
```

## The HTML tag

Then include the following HTML in any part of your website:

```html
<div class="simple-gmaps">
  <div class="my-marker" data-lat="-37.123123" data-lng="-58.4324234">
    That's it, this is an stylable element.
  </div>
</div>
```

`data-lat` and `data-lng` are the latitude and longitude where the map marker is being set.
To find out these values just head to [Google Maps](http://maps.google.com) and press SHIFT while hovering over any
part of the map.


## Multiple markers

```html
<div class="simple-gmaps">
  <div class="my-marker" data-lat="-37.123123" data-lng="-58.4324234">
    It couldn't get
  </div>
  <div class="other-marker" data-lat="-37.123123" data-lng="-58.4324234">
    any simpler than this
  </div>
</div>
```

It's pretty much self-explanatory, you add multiple elements with `data-lat` and `data-lng`.

## About the CSS

There is just this simple rule, you can't match the elements doing:

```css
.simple-gmaps > div {

}

```

Because the elements are removed from DOM and inserted inside a jungle of Google Maps DOM elements.

And another thing, you can use the class `.active` in your CSS, it will match the last clicked element.

## Autorun or manual

If you want to do it as simple as possible,
without writing JavaScript, just include the autorun script:

```html
<script type="text/javascript" src="/path/to/google_maps_markers.jquery.autorun.min.js"></script>
```

Doing that is the same as:

```html
<script type="text/javascript" src="/path/to/google_maps_markers.min.js"></script>
<script type="text/javascript">
  jQuery(function(){
    $('.simple-gmaps').simpleGmapsMarkers();
  });
</script>
```

## Credits

By [Ezequiel Schwartzman](http://zequez.com), at [Avalith](http://avalith.net/).

[Infobox libraray](https://code.google.com/p/google-maps-utility-library-v3/) for Google Maps API

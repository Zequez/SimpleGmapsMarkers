# Simple Gmaps Markers

Simple Gmaps Markers es una pequeña libraría para crear un marcador customizado
de Google Maps sin tener que escribir ni una sola linea de JavaScript.

Esto es algo muy utilizado en muchos sitios web, algo que debería ser simple, pero
la única forma simple de hacerlo es incluir un iframe. El problema es que esto
solo te permite usar un marcador con una fea A roja y un cartel blanco gigante incustomizable.

Si sos una persona de acción, puedes ver el ejemplo en la carpeta /example.

## Preparando todo

Primero, *debemos* incluir la API de Google Maps v3, para hacer esto, incluimos
el siguiente script dentro del head:

```html
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
```

Luego solo tenemos que incluir la librería de SimpleGmapsMarkers:

```html
<script type="text/javascript" src="/path/to/google_maps_marker.jquery.autorun.min.js"></script>
```

## El HTML

Luego incluye el siguiente HTML en cualquier parte de ti sitio web:

```html
<div class="simple-gmaps">
  <div class="simple-gmaps-marker" data-lat="-37.123123" data-lng="-58.4324234">
    Listo, cualquier cosa que pongas acá dentro se puede estilar con CSS.
  </div>
</div>
```

`data-lat` y `data-lng` son la latitud y la longitud donde el marcador se va a posicionar.
Para encontrar estos valores simplemente ve a [Google Maps](http://maps.google.com), mueve
el mouse sobre la posición y presiona SHIFT.

## Marcadores múltiples

```html
<div class="simple-gmaps">
  <div class="simple-gmaps-marker" data-lat="-37.123123" data-lng="-58.4324234">
    No podría ser
  </div>
  <div class="simple-gmaps-marker" data-lat="-37.123123" data-lng="-58.4324234">
    más simple que esto
  </div>
</div>
```

Se explica solo, simplemente agrega múltiples `simple-gmaps-marker`.

## Autorun o manual

Si lo quieres hacer lo más simple posible, sin escribir
JAvaScript, simplemente incluye el script con autorun:

```html
<script type="text/javascript" src="/path/to/google_maps_markers.jquery.autorun.min.js"></script>
```

Que es prácticamente lo mismo que hacer lo siguiente:

```html
<script type="text/javascript" src="/path/to/google_maps_markers.min.js"></script>
<script type="text/javascript">
  jQuery(function(){
    $('.simple-gmaps').simpleGmapsMarkers();
  });
</script>
```

## Créditos

By [Ezequiel Schwartzman](http://zequez.com), at [Avalith](http://avalith.net/).


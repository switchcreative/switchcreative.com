# Define Elements
$header = $("#l-header")
$asyncImages = $("[data-behavior='delayedImage']")

# Spinner Options
spinnerOpts =
  lines:   11 # The number of lines to draw
  length:  4  # The length of each line
  width:   3  # The line thickness
  radius:  7 # The radius of the inner circle
  corners: 1  # Corner roundness (0..1)
  rotate:  0  # The rotation offset
  color:   "#bbb" # #rgb or #rrggbb
  speed:   1  # Rounds per second
  trail:   60 # Afterglow percentage
  shadow:  false # Whether to render a shadow
  hwaccel: false # Whether to use hardware acceleration
  className: 'spinner' # The CSS class to assign to the spinner
  zIndex:  2e9   # The z-index (defaults to 2000000000)
  top:     'auto' # Top position relative to parent in px
  left:    'auto' # Left position relative to parent in px

# Load Images Asynchronously
$.fn.asyncImageLoad = ->
  $(@).each (index) ->
    $this = $(@)
    $this.show().css("min-height", "3em")
    spinner = new Spinner(spinnerOpts).spin($this[0])

    src = $this.data("src")
    if src
      $img = $("<img>")
      loaded = $img.attr("src", src).imagesLoaded()
      loaded.progress (isBroken) ->
        if isBroken
          $this.fadeOut(500)
        else
          $img.hide()
          $(document).queue (nextDocQueue) ->
            $this.replaceWith($img).queue (next) ->
              $img.fadeIn(1000)
              nextDocQueue()
        showHeader() if index is 0

# Fade in header
showHeader = ->
  $header.delay(500).fadeIn(1700)

jQuery ->
  # Hide header, fade-in immediately
  # if there are no async images
  $header.hide()
  unless $asyncImages.length > 0
    showHeader()
  # Initialize async images
  $asyncImages.asyncImageLoad()

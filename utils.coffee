sizeOf = require('image-size')
path   = require('path')

module.exports.context = (req, res, next) ->
  res.locals.path = req.path
  # Unable debug mode
  res.locals.debugMode = req.query.hasOwnProperty("debug")
  next()



class Utils
  ###*
   * Step context style
   * @param  {Object} data Step descriptor
   * @return {String}      CSS style
  ###
  stepStyle: (step) ->
    style = []

    # Add style
    style.push step.style  if step.style
    style.join ";"

  ###*
   * Spot context style
   * @param  {Object} data Spot descriptor
   * @return {String}      CSS style
  ###
  spotStyle: (spot)=>
    toPx = (val)->
      (if isNaN(val) then val else val + "px")

    style = []
    picsize  = @pictureSize(spot)

    # Add position
    style.push "top:" + toPx(spot.top or 0)
    style.push "left:" + toPx(spot.left or 0)

    width = spot.width or "0"
    # Use an other default height if a picture is given
    width = if picsize.width? then picsize.width else width
    # Cut the height by 2
    if spot["half-width"]
      width = width/2
      style.push "overflow:hidden"
    style.push "width:" + toPx(width)

    height = spot.height or spot.width or "0" # Square by default
    # Use an other default height if a picture is given
    height = if picsize.height? then picsize.height else height
    # Cut the height by 2
    if spot["half-height"]
      height = height/2
      style.push "overflow:hidden"
    # Add the height
    style.push "height:" + toPx(height)

    # Add style
    style.push spot.style  if spot.style
    style.join ";"

  ###*
   * Spot's wrapper context style
   * @param  {Object} data Spot descriptor
   * @return {String}      CSS style
  ###
  spotWrapperStyle: (spot) ->
    style = []

    # Add background
    style.push "background-image: url(" + spot.background + ")"  if spot.background

    # Add style
    style.push spot.wrapperStyle  if spot.wrapperStyle
    style.join ";"

  ###*
   * Step context classes
   * @param  {Object} data Step descriptor
   * @return {String}      Classes
  ###
  stepClass: (step) ->
    klass = []

    # Step classes
    klass.push step.class  if step.class?
    klass.join " "

  ###*
   * Spot context classes
   * @param  {Object} data Spot descriptor
   * @return {String}      Classes
  ###
  spotClass: (spot)->
    klass = []
    # Special class for element with a tooltip
    klass.push "js-tooltip" if spot.tooltip?
    # Spot classes
    klass.push spot.class if spot.class?
    klass.join " "

  ###*
   * Template helper to remove html tags (to plain text)
   * @copyright http://kevin.vanzonneveld.net
   * @param  {String} input   HTML to escape
   * @param  {String} allowed  Allowed tags (ex: <a><b><em>)
   * @return {String}         Input string as plain text
  ###
  strip_tags: (input, allowed) ->
    # short fail
    return unless input?
    # http://kevin.vanzonneveld.net
    allowed = (((allowed or "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) or []).join("") # making sure the allowed arg is a string containing only tags in lowercase (<a><b><c>)
    tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/g
    commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/g
    input.replace(commentsAndPhpTags, "").replace tags, ($0, $1) ->
      (if allowed.indexOf("<" + $1.toLowerCase() + ">") > -1 then $0 else "")

  pictureSize: (spot)->
    width = height = undefined
    if spot.picture? and spot.picture.src?
      # Size from file
      if spot.picture.retina
        try
          size   = sizeOf path.join("public", spot.picture.src)
          width  = size.width/2
          height = size.height/2
        catch e
          # Nothing to do if file is not extracted
      # Size from option
      width = if spot.picture.width? then spot.picture.width else width
      height = if spot.picture.height? then spot.picture.height else height
    return {
      width: width
      height: height
    }



### Locals functions (available in any template) ###
module.exports.locals = new Utils()
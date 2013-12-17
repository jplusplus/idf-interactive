module.exports.context = (req, res, next) ->    
  res.locals.path = req.path
  # Unable debug mode
  res.locals.debugMode = req.query.hasOwnProperty("debug")
  next()


### Locals functions (available in any template) ###
module.exports.locals =
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
  spotStyle: (spot) ->
    toPx = (val) ->
      (if isNaN(val) then val else val + "px")

    style = []
    
    # Add position
    style.push "top:" + toPx(spot.top or 0)
    style.push "left:" + toPx(spot.left or 0)
    
    # Add size
    style.push "width:" + toPx(spot.width)
    style.push "height:" + toPx(spot.height or spot.width) # Square by default
    
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
   * Spot context classes
   * @param  {Object} data Spot descriptor
   * @return {String}      Classes
  ###
  spotClass: (spot) ->
    klass = []
    
    # Spot classes
    klass.push spot.class  if spot.class
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

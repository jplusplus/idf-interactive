###
Module dependencies.
###
express = require("express")
http = require("http")
path = require("path")
app = express()

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.set "page", "page/"
  app.set "data", __dirname + "/data"
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use require("connect-assets")(src: __dirname + "/public")
  app.use express.static(path.join(__dirname, "public"))
  app.use (req, res, next) ->
    res.locals.path = req.path
    next()
  
  ###
  Views helpers
  ###
  
  # Register helpers for use in view's
  app.locals
    stepStyle: (step) ->
      style = []
      
      # Add style
      style.push step.style  if step.style
      style.join ";"

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

    spotWrapperStyle: (spot) ->
      style = []
      
      # Add background
      style.push "background-image: url(" + spot.background + ")"  if spot.background
      
      # Add style
      style.push spot.wrapperStyle  if spot.wrapperStyle
      style.join ";"

    spotClass: (spot) ->
      klass = []
      
      # Spot classes
      klass.push spot.class  if spot.class
      klass.join " "

    strip_tags: (input, allowed) ->
      
      # http://kevin.vanzonneveld.net
      allowed = (((allowed or "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) or []).join("") # making sure the allowed arg is a string containing only tags in lowercase (<a><b><c>)
      tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/g
      commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/g
      input.replace(commentsAndPhpTags, "").replace tags, ($0, $1) ->
        (if allowed.indexOf("<" + $1.toLowerCase() + ">") > -1 then $0 else "")


  
  # Add context helpers
  app.use (req, res, next) ->
    
    # Unable debug mode
    res.locals.debugMode = req.query.hasOwnProperty("debug")
    next()
 
  ###
  Configure router
  ###
  
  # @warning Needs to be after helpers
  app.use app.router
  
  # Load the default route file
  require("./routes") app

app.configure "development", ->
  app.use express.errorHandler()

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

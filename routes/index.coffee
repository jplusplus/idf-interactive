# Dependencies
path = require("path")
fs   = require("fs")
_    = require("underscore")

# Module variables
app = undefined
module.exports = (a) ->
  app = a
  app.get "/:page/index.html", routePage
  app.get "/:page.html", routePage
  app.get "/:page/:step/:spot", editSpotPosition

routePage = (req, res) ->
  # Template file
  tplDir = app.get("page")
  tplName = req.params.page + "." + app.get("view engine")
  dataDir = app.get("data")
  dataName = req.params.page + ".json"
  # Template file path
  tpl = path.join(app.get("views"), tplDir, tplName)
  # Data file path
  json = path.join(dataDir, dataName)
  # Do the data file exist ?
  return res.send(404, "Data file not found.")  unless fs.existsSync(json)

  if req.query.debug?
    # Refresh the require if we are in debug mode cache
    name = require.resolve(json)
    delete require.cache[name];
  # Parse the json file
  data = require(json)
  # Inspect the daya to improve some elements
  for step in data.steps
    # Inspect every spots
    for spot in step.spots
      # This spot has a series of point
      if spot.series?
        # A spot with a series must avec sizes
        spot.width = spot.width ? 300
        spot.height = spot.height ? spot.height
        # Get bounds values for x
        xmin = _.min(spot.series, (e)-> e.x).x
        xmax = _.max(spot.series, (e)-> e.x).x
        # Get bounds values for y
        ymin = _.min(spot.series, (e)-> e.y).y
        ymax = _.max(spot.series, (e)-> e.y).y
        # Each series' element must be transform into a spot
        for e in spot["series"]
          # Calculate the position of each element according to
          # the bounds of the series
          e.left = 100*(e.x - xmin)/(xmax-xmin) + "%"
          e.top  = 100-(100*(e.y - ymin)/(ymax-ymin)) + "%"
          e.origin = "center"
          # Spot options
          e = _.extend e, spot["series-options"] or { width: 10, height: 10 }
  # Render the page template
  # Use the default template if needed
  res.render path.join(tplDir, (if fs.existsSync(tpl) then req.params.page else "default")),
    data: data
    page: req.params.page


editSpotPosition = (req, res) ->
  step = req.params.step
  spot = req.params.spot

  # Forbidden in production!
  return res.send(403) if process.env.NODE_ENV is "production"

  # Do we received the position ?
  return res.send(500)  if not req.query.top or not req.query.left
  dataDir  = app.get("data")
  dataName = req.params.page + ".json"
  dataPath = path.join(dataDir, dataName)
  data = require(dataPath)
  # Does the spot exist ?
  return res.send(404) if not data or not data.steps or not data.steps[step] or not data.steps[step].spots[spot]

  # Edit the data
  data.steps[step].spots[spot].top = req.query.top
  data.steps[step].spots[spot].left = req.query.left
  dataString = JSON.stringify(data, null, 4)

  # Mades it persistent
  fs.writeFile dataPath, dataString

  # Send the resut now
  res.send 200
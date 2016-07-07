yaml = require 'js-yaml'
fs   = require 'fs'
path = require 'path'

class Humbill

  @configure: (@root_dir) ->
    Humbill.Models.Menu.default_hash = yaml.safeLoad (
      fs.readFileSync path.join @root_dir, "config/menu.yml")


    @app_dir = path.join @root_dir, 'app'
    @audio_dir = path.join @app_dir, 'audio'
    @views_dir = path.join @app_dir, 'views'
    @layouts_dir = path.join @views_dir, 'layouts'
    @controllers_dir = path.join @app_dir, 'controllers'
    @invoices_dir = path.join @root_dir, 'invoices'
    @css_base = './app/stylesheets/'
    @audio_base = './app/audio/'


  @Models = 
    Menu: require './models/menu.coffee'

  ControllerStack = require './controllers/controller'
  _stack = new ControllerStack()

  @Controllers = 
    stack: _stack



module.exports = Humbill


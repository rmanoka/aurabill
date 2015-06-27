$       = global.$
hamlc   = require 'haml-coffee'
fs      = require 'fs'
path    = require 'path'

require './dom_controller'

DOMController = Humbill.Controllers.DOMController
the_stack = Humbill.Controllers.the_stack

class LoopController extends Controller
  constructor: (@elements) ->
    @currIndex = -1

  pushed: () ->
    @timer = setInterval(
      () ->
        the_stack.dispatch
          name: 'LoopController'


      , 1000)

  action: (args) ->
    html?.name? == 'LoopController' || return false
    
    $(@elements[@currIndex]).removeClass "selected"  if (@currIndex != -1)

    @currIndex++;
    if (@currIndex == @elements.length)
      @currIndex = 0;

    $(@elements[@currIndex]).addClass "selected"
    return true

  choose: () ->
    if (@currIndex == -1)
      return
    the_stack.pop()



  popping: () ->
    clearInterval @timer

class MenuViewController extends DOMController
  constructor: (element, @menu) ->
    @menu ?= new Humbill.Models.Menu
    super element

  action: () ->
    menu_data = 
      'menu': @menu
    menu_view_file = path.join Humbill.views_dir, "menu", "choose.html.hamlc"
    super ((hamlc.compile fs.readFileSync menu_view_file, 'utf8') menu_data)
    css_href = @menu.property('_layout') ? 'screen'      
    @load_css css_href, true

    @loop_controller = new LoopController(@element.find('*[data-cycle]'))
    the_stack.push(@loop_controller)

    @on_action () ->
      setInterval(
        () -> 
          the_stack.dispatch()
        , 1000)

    return true
    
Humbill.Controllers["MenuController"] = MenuController

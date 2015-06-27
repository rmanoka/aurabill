stack = global.Humbill.Controllers.stack
$     = global.$


class Timer
  constructor: (interval=1000, @message) ->    
    @timer = setInterval (() => @ticker()), interval

  ticker: () ->
    stack.send(@message) 

  reset: () ->
    clearInterval(@timer)

class ClickController
  constructor: (@element, @message) ->
    $(@element).click(() => 
      $(@element).off('click')
      stack.send(@message))


class ChoiceController
  constructor: (@elements, root, interval = 1000) ->
    stack.push @
    @timer = new Timer(interval, {
        'shift': true
      })
    @currIndex = -1
    new ClickController(root, {
      'choose': true
    })
    
  shift: () ->
    $(@elements[@currIndex]).removeClass "selected"  if (@currIndex != -1)

    @currIndex++;
    if (@currIndex == @elements.length)
      @currIndex = 0;

    $(@elements[@currIndex]).addClass "selected"

  choose: () ->
    return unless (@currIndex >=0 && @currIndex < @elements.length)
    @timer.reset()
    stack.pop {
      option: $(@elements[@currIndex]).data().option
    }
    $(root).off('click')


path = require 'path'
DOMController = require './dom_controller'

class MenuController extends DOMController
  constructor: (@root_element, @menu) ->
    super @root_element

    stack.push(@)
    @menu ?= new Humbill.Models.Menu()

    @show_menu()
    return

  option: (opt) ->
    if (opt == '_back')
      console.log('menu_controller: _back received')
      if @menu.root()
        console.log('menu_controller: root node. popping\n')
        return stack.pop {
          'menu': null
        }
      else
        @menu.back()
    else
      @menu.choose(opt)

    if @menu.leaf()
      stack.pop {
        'menu': @menu
      }
    else
      @show_menu()

  show_menu: () ->
    @show_view (path.join 'menu', 'choose.html.hamlc'), {
      'menu': @menu
    }
    
    @load_css (@menu.property('_layout') ? 'screen'), true

    @choice_controller = new ChoiceController(@root_element.find('*[data-cycle]'), @root_element)

    
Humbill.Controllers["MenuController"] = MenuController
Humbill.Controllers.ClickController = ClickController

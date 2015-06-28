stack = global.Humbill.Controllers.stack
$     = global.$

Speaker = require ('speaker')
fs = require 'fs'



class Timer
  constructor: (interval=1000, @message) ->    
    @timer = setInterval (() => @ticker()), interval

  ticker: () ->
    stack.send(@message) 

  reset: () ->
    clearInterval(@timer)

class Timeout extends Timer
  constructor: (interval=1000, @message) ->
    @timeout = setTimeout (() => @ticker()), interval
    return

  reset: () ->
    clearTimeout(@timeout)



class ClickController
  constructor: (@element, @message) ->
    $(@element).click(() => 
      $(@element).off('click')
      stack.send(@message))


class ChoiceController
  constructor: (@elements, @root, interval = 1000) ->
    stack.push @
    @done = false
    @interval = interval
    @timer = new Timeout(interval, {
        'shift': true
      })
    @currIndex = -1
    new ClickController(@root, {
      'choose': true
    })

  play_audio: (file) ->    
    @speaker = new Speaker()
    @speaker.write(fs.readFileSync(path.join Humbill.audio_dir, file), null, 
      () =>
        if not @done
          @set_shift_timer())        
    
  shift: () ->
    $(@elements[@currIndex]).removeClass "selected"  if (@currIndex != -1)

    @currIndex++;
    if (@currIndex == @elements.length)
      @currIndex = 0;

    $(@elements[@currIndex]).addClass "selected"

    if (a = $(@elements[@currIndex]).data().audio)
      @play_audio(a)
    else
      @set_shift_timer()
    
  set_shift_timer: () ->
    @timer = new Timeout(@interval, {
      'shift': true
    })


  choose: () ->
    return new ClickController(@root, {
      'choose': true
    }) unless (@currIndex >=0 && @currIndex < @elements.length)
    @done = true
    @timer.reset()
    stack.pop {
      option: $(@elements[@currIndex]).data().option
    }


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
      if @menu.root()
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

    @choices = []
    for opt in @menu.options()
      
      audio_link = @menu.property(opt)['_audio']? && @menu.property(opt)['_audio']
      
      image_link = @menu.property(opt)['_image']? && @menu.property(opt)['_image']
      if image_link then image_link = "app/images/" + image_link

      @choices.push({
        'id': opt
        'name': @menu.property(opt)['_name'] ? opt
        'audio': audio_link,
        'image': image_link
      })

    @show_view (path.join 'menu', 'choose.html.hamlc'), {
      'choices': @choices
      'name': @menu.property '_name'
    }
    
    @load_css (@menu.property('_layout') ? 'screen'), true

    @choice_controller = new ChoiceController(@root_element.find('*[data-cycle]'), @root_element)

    
Humbill.Controllers["MenuController"] = MenuController
Humbill.Controllers.ClickController = ClickController

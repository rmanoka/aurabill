Humbill = global.Humbill ? require '../../humbill'
$ = global.$


class ControllerStack

  _instance = null

  class _ControllerStackImpl
    constructor: ->
      @_stack = []

    dispatch: (args) ->
      while (not (
        c = @_stack[@_stack.length? - 1] || 
        throw Error("Humbill: unable to dispatch: no suitable controller on stack")
      ).action(args)
        c.pop()

    push: (s) ->
      @_stack.push (s)
      s.pushed()

    peek: () ->

      null unless (c = @_stack.length)
      @_stack[]

    pop: ->     
      throw Error("Humbill: popping empty stack.") unless (c = @_stack.length)      
      @_stack[c-1].popping()
      @_stack.pop()
      
  @instance: () ->
    _instance ?= new _ControllerStackImpl()

Humbill.Controllers.the_stack = ControllerStack.instance()

class Controller 
  pushed: () ->
  popping: () ->
  constructor: () ->
    push_to_stack()
  push_to_stack: () ->
    Humbill.Controllers.the_stack.push(@)
  action: () ->
    false  

class DOMController extends Controller
  constructor: (@element) ->

  action: (html) ->
    html?.name? == 'DOMController' || return false
    @element.html(html) || true


  on_action: (func) -> $?().ready(func)


Humbill.Controllers.Controller = Controller
Humbill.Controllers.DOMController = DOMController

# $('<link/>', {rel: 'stylesheet', href: 'myHref'}).appendTo('head');


class ControllerStack

  pcon_debug = false
  pcon = (arg) ->
    if pcon_debug
      console.log arg
    
  constructor: () ->
    @_stack = []

  push: (c) ->
    @_stack.push(c)

    pcon('==in controller.coffee')
    pcon('controller pushed')
    pcon @
    pcon("\n\n")



  pop: (message) ->    
    @_stack.pop()
    @send message if message?

    pcon '==in controller.coffee'
    pcon 'controller popped'    
    pcon @
    pcon '\n\n'

  send: (message) ->

    pcon '==in controller.coffee'
    pcon 'sending messages'
    for k,v of message
      pcon 'message: ' + k + ' with params:\n' + v
      @_stack[@_stack.length - 1][k] v

module.exports = ControllerStack


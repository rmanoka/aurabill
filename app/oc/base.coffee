class Controller
  action: (obj) ->
    throw Error("Base can't act!!!")

class ControllerStack extends Controller
  constructor: () ->
    @_stack = []  

  push: (c) -> @_stack.push c

  pop: () -> @_stack.pop()

  action: (obj) ->    
    while not ((c = @_stack[@_stack.length - 1]?.action?(obj)) || (@_stack.length == 0))
      @pop()
    return c



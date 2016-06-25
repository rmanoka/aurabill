class Menu
  constructor: (@hash, @menu) ->
    @hash ?= Menu.default_hash
    @menu ?= 'Menu'

    @current_node = @hash[@menu]
    @current_node['_name'] ?= @menu
    @node_stack = []

  options: () ->
    (key for key, value of @current_node when key[0] != '_')

  leaf: () ->
    @options().length == 0

  root: () ->
    ((@node_stack.length == 0) || @current_node['_root']?)

  choose: (option) ->
    @node_stack.push(@current_node)
    @current_node = @current_node[option]
    @current_node['_name'] ?= option

  back: () ->
    if (@node_stack.length)
      @current_node = @node_stack.pop()

  property: (property) ->
    @current_node[property]

  reset: () ->
    @current_node = @hash[@menu]
    @node_stack = []

  @default_hash = null

module.exports = Menu

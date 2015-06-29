stack = global.Humbill.Controllers.stack
$     = global.$
path  = require 'path'
DOMController = require './dom_controller.coffee'
require './menu_controller'


StateMachine =
  state: (_state, args) ->
    if _state?
      @[(@_state = _state)](args)
    else
      @_state

class NewInvoiceController extends DOMController

  for key, val of StateMachine
    @::[key] = val

  INVOICE_SCREEN  = "invoice_screen"
  ITEM_MENU       = "item_menu"
  QUANTITY_MENU   = "quantity_menu"
  CONTINUE_MENU   = "continue_menu"

  constructor: (@root_element, @invoice) ->
    super @root_element
    stack.push @

    d = new Date()
    date_string = d.getDate() + '-'
    date_string += d.getMonth() + '-' + d.getFullYear()

    id_string = "" + d.getHours() + d.getMinutes() + d.getSeconds()
    if not @invoice?
      @invoice = 
        'id': id_string
        'date': date_string
        'items': [
          'name': 'Coffee'
          'price': 10.00
          'quantity': 2
        ,
          'name': 'Brownie'
          'price': 50.00
          'quantity': 1
        ,
          'name': 'Smile'
          'price': 100000.00
          'quantity': 1
        ]

    @state(INVOICE_SCREEN)
    return

  invoice_screen: () ->
    @show_view (path.join 'invoice', 'new.html.hamlc'), {
      'invoice': @invoice
      'format_rupees': (args) -> args + ".00"
    }    
    @load_css 'invoice', true
    new Humbill.Controllers.ClickController(@root_element, {
      'menu': true
    })
  item_menu: () ->
    new Humbill.Controllers.MenuController(
      @root_element, 
      new Humbill.Models.Menu
    )
  quantity_menu: () ->
    m = new Humbill.Models.Menu
    m.choose '_Qty'
    new Humbill.Controllers.MenuController(@root_element, m)
  continue_menu: () ->
    m = new Humbill.Models.Menu
    m.choose '_Add_More'
    new Humbill.Controllers.MenuController(@root_element, m)
      

    
  menu: (menu_item) ->
    switch @state()
      when INVOICE_SCREEN
        @state CONTINUE_MENU

      when CONTINUE_MENU
        if not menu_item?
          @state INVOICE_SCREEN
        else
          switch menu_item.property('_option')
            when 'add_item'
              @state ITEM_MENU
            when 'print'
              return stack.pop {
                'invoice': @invoice
              }
              
      when ITEM_MENU
        if not menu_item?
          @state CONTINUE_MENU
        else
          @row_to_add = 
            'name': menu_item.property '_name'
            'price': menu_item.property '_price'
          @state QUANTITY_MENU

      when QUANTITY_MENU
        if not menu_item?
          @state CONTINUE_MENU
        else
          @row_to_add.quantity = menu_item.property '_name'
          @invoice.items.push @row_to_add
          @state INVOICE_SCREEN

global.Humbill.Controllers.NewInvoiceController = NewInvoiceController

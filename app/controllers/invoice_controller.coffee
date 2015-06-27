stack = global.Humbill.Controllers.stack
$     = global.$
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

  INVOICE_SCREEN  = 'invoice_screen'
  ITEM_MENU       = "item_menu"
  QUANTITY_MENU   = "quantity_menu"
  CONTINUE_MENU   = "continue_menu"

  constructor: (@root_element) ->
    super @root_element
    stack.push @

    @invoice = 
      id: 1001
      date: 'June 10, 2015'
      items: [
        name: 'Coffee'
        price: 10.00
        quantity: 2
      ,
        name: 'Brownie'
        price: 50.00
        quantity: 1
      ,
        name: 'Smile'
        price: 10000.00
        quantity: 1
      ,
        name: 'Brownie'
        price: 50.00
        quantity: 1
      ,
        name: 'Smile'
        price: 10000.00
        quantity: 1
      ,
        name: 'Brownie'
        price: 50.00
        quantity: 1
      ,
        name: 'Smile'
        price: 10000.00
        quantity: 1
      ,
        name: 'Brownie'
        price: 50.00
        quantity: 1
      ,
        name: 'Smile'
        price: 10000.00
        quantity: 1
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
        console.log('invoice_controller: in state CONTINUE_MENU,\n')
        console.log('  menu_item = ')
        console.log(menu_item)        
        if not menu_item?
          @state INVOICE_SCREEN
        else
          switch menu_item.property('_option')
            when 'add_item'
              @state ITEM_MENU
            when 'print'
              @state INVOICE_SCREEN

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

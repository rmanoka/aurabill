p = console.log

add_to_class = (klass, hash) ->
  for key, val of hash
    klass[key] = val

extend_simple = (ca, cb) ->
  cb ?= @
  cb.__proto__ = ca
  cb.prototype.__proto__ = ca.prototype.__proto__


a = [
  name: 'Coffee'
  price: 10.00
  quantity: 2
,
  name: 'Tea'
  price: 20.00
  quantity: 3
]

p a

# class A
#   constructor: () ->
#     @another_method()

#   another_method: () ->
#     p 'hi'

# a = new A()


# class MenuController
#   constructor: (@root_element, @menu) ->
#     @show_menu()

#   show_menu: () ->
#     p 'hi'
#     menu_data = 
#       'menu': @menu
#     # menu_view_file = path.join Humbill.views_dir, "menu", "choose.html.hamlc"
#     # super ((hamlc.compile fs.readFileSync menu_view_file, 'utf8') menu_data)
#     # css_href = @menu.property('_layout') ? 'screen'      
#     # @load_css css_href, true

#     # @choice_controller = new ChoiceController(@element.find('*[data-cycle]'))
    
# m = new MenuController()


# class MenuController
#   #@states = ['menu']

#   constructor: (@menu) ->

#   transition: (option) ->
#     @menu = @menu.choose(option) ? @menu
#     showMenu



# class Invoice
#   newInvoice: () ->

#     items = []
    
#     loop      
#       item = new MenuController(root_item)
#       item_quantity = new MenuController(root_qty)
#       items.push ((item, item_quantity))
#       break unless new MenuController(root_more_items) == 'more_items'

# class MenuController
#   constructor: () ->

#     # process items





# p (() ->
#   return {
#     menu: 10})()['menu']
  


# A = (args...) -> 
#   o = Array(args...)
#   o.__proto__ = A.prototype
#   return o
# extend_simple Array, A

# a = new A()
# p a
# a.push 10
# p a.peek()


# class B 
#   extend_simple A, B
#   add_to_class B, {
#     consume: () ->

#     push: () ->
#     pop: () ->
#   }

# p B.consume()

# p B.__proto__ == A
# p 'should be: [true]...\n'

# class A
#   @value = 1
#   @method: () -> 1

#   constructor: () -> 
#     return {
#       prop: 10
#     }


# class B 
#   extend_simple A, B

# a = 
#   data: 10

# class A
#   constructor: () ->
#     return a

# b = new A()
# p b.data
# p "should be 10...\n"

# b.data = 20
# p a.data
# p "should be 20...\n"

  
# a = new A()
# p a.__proto__ == {}.__proto__

# p CA.__proto__ = 
# p CB()

# CB.value.true_value = 2
# p CA.value.true_value
# p "should be 2...\n"

# b = Object.create(CB)
# p b.chumma_method()
# p "should be 3...\n"

#  == Object.prototype
# p(b.chumma_method())



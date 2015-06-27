Humbill = global.Humbill ? require '../../humbill'
$ = global.$

class DOMController extends Controller
  constructor: (@element) ->

  action: (obj) ->
    
    html?.name? == 'DOMController' || return false
    @element.html(html) || true

  load_css: (css_href, cache_bust) ->    
    css_href = Humbill.css_base + css_href + ".css"
    if (cache_bust)
      css_href += '?bust=' + ((new Date).getTime())
    $?('<link/>', {
      rel: 'stylesheet', 
      href: css_href}).appendTo('head')

  on_action: (func) -> $?().ready(func)


Humbill.Controllers.Controller = Controller
Humbill.Controllers.DOMController = DOMController

# $('<link/>', {rel: 'stylesheet', href: 'myHref'}).appendTo('head');


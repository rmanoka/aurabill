hamlc   = require 'haml-coffee'
fs      = require 'fs'
path    = require 'path'
$       = global.$

class DOMController
  constructor: (@root_element) ->

  show_view: (view_path, data) ->
    view_file = path.join Humbill.views_dir, view_path
    $(@root_element).html ((hamlc.compile fs.readFileSync view_file, 'utf8') data)

  load_css: (css_href, cache_bust = false) ->    
    css_href = Humbill.css_base + css_href + ".css"
    if (cache_bust)
      css_href += '?bust=' + ((new Date).getTime())    
    $?('link[rel="stylesheet"]').remove()
    $?("document").ready () ->
      $?('<link/>', {
        rel: 'stylesheet',
        type: 'text/css',
        media: 'screen, projection'
        href: css_href}).appendTo('head') 

module.exports = DOMController

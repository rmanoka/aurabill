path    = require 'path'
fs      = require 'fs'
Humbill = require './humbill.coffee'
$       = global.$
Humbill.configure path.join __dirname, ".."
global.Humbill = Humbill


require './controllers/app_controller'

$?("document").ready () ->  
  new Humbill.Controllers.AppController()
  # # $?("document").ready (console.log("hi"))
  # #m = new Humbill.Models.Menu  
  # #mc = new Humbill.Controllers.MenuController(($ "body"), m)  
  # new_invoice = new Humbill.Controllers.NewInvoiceController($ "body")


# console.log ((hamlc.compile fs.readFileSync menu_view_file, 'utf8') menu_data)
# $("body").html("")
# require './controllers/sample_window.js'

stack = global.Humbill.Controllers.stack

require './invoice_controller.coffee'
yaml = require 'js-yaml'
fs   = require 'fs'
path = require 'path'

class AppController
  constructor: () ->
    stack.push @
    @invoice()

  invoice: (inv) ->
    @save_invoice(inv) if inv?
    new Humbill.Controllers.NewInvoiceController($ "body")

  save_invoice: (inv) ->
    fs.writeFileSync(
      path.join(
        Humbill.invoices_dir, (inv.date + '-' + inv.id + ".yml")),
      yaml.safeDump(inv))


global.Humbill.Controllers.AppController = AppController

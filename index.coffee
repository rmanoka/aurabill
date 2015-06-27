app = require 'app'
package_json = require './package.json'
BrowserWindow = require 'browser-window'

mainWindow = null
app.on 'window-all-closed', -> 
  app.quit

app.on 'ready', ->
  mainWindow = new BrowserWindow package_json["window"]    
  mainWindow.loadUrl 'file://' + __dirname + '/index.html'
  # mainWindow.openDevTools
  mainWindow.setMenu null
  mainWindow.openDevTools true
  mainWindow.on 'closed', ->
    mainWindow = null


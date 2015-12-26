{$,View} = require 'atom-space-pen-views'
{CompositeDisposable} = require 'atom'
request = require 'request'
shell = require 'shell'
jsdom = require 'jsdom'

#apd = require 'atom-package-dependencies'
#browser = apd.require 'link'
#alert JSON.stringify(Object.keys(BrowserWindow))

module.exports =
class AtomTinderView extends View
  @content: ->
    resources = "#{atom.packages.getLoadedPackage('atom-tinder').path}/resources"
    @div class: 'atom-tinder', =>
      @div class: 'atom-tinder-container atom-tinder-hidden', =>
        @div class: 'group', =>
          @button id: 'swipe-left', class:'btn icon icon-x' #, click:''
          @img id: 'image', class: 'image', src: "#{resources}/proto.png"
          @button id: 'swipe-right', class:'btn icon icon-check' #, click:''
      @div class: 'atom-tinder-login', =>
        @button 'login to facebook', id: 'facebook-login', click: 'login'

  initialize: ->
    @subscriptions = new CompositeDisposable

  show: ->
    request {
      url: 'http://localhost:3000'
    }, (err, res, body) =>
      alert JSON.stringify(body)
      if not err and body.status? == true
          $('.atom-tinder-login').toggleClass('atom-tinder-hidden')
          $('.atom-tinder-container').toggleClass('atom-tinder-hidden')

      @panel ?= atom.workspace.addBottomPanel(item:this)
      @panel.show()

  open: ->
    if @panel?.isVisible()
      @hide()
    else
      @show()

  login: ->
    #browser.openInBrowsersView.openChrome null, "http://localhost:3000/auth"
    shell.openExternal 'http://localhost:3000/auth'
    #jsdom.env "http://localhost:3000/auth", ["http://code.jquery.com/jquery.js"], (err, win) ->
        #atom.workspace.open win.$('html')

  hide: ->
    @panel?.hide()

  serialize: ->

  destroy: ->
    @subscriptions.dispose()

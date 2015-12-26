AtomTinderView = require './atom-tinder-view'

module.exports = AtomTinder =
  atomTinderView: null

  activate: (state) ->
    @atomTinderView = new AtomTinderView(state.atomTinderViewState)
    atom.commands.add 'atom-workspace', 'atom-tinder:open': => @atomTinderView.open()

  deactivate: ->
    @atomTinderView.destroy()

  serialize: ->
    atomTinderViewState: @atomTinderView.serialize()

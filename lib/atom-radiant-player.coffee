AtomRadiantStatusBarView = require './atom-radiant-player-status-bar-view'

module.exports =
  config:
    displayOnLeftSide:
      type: 'boolean'
      default: true
    showEqualizer:
      type: 'boolean'
      default: false
    showPlayStatus:
      type: 'boolean'
      default: true
    showPlayIconAsText:
      type: 'boolean'
      default: false

  activate: ->
    atom.packages.onDidActivateInitialPackages =>
      @statusBar = document.querySelector('status-bar')

      @radiantView = new AtomRadiantStatusBarView()

      @radiantView.initialize()

      if atom.config.get('atom-radiant-player.displayOnLeftSide')
        @statusBar.addLeftTile(item: @radiantView, priority: 100)
      else
        @statusBar.addRightTile(item: @radiantView, priority: 100)

  deactivate: ->
    @radiantView?.destroy()
    @radiantView = null

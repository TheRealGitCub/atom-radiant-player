AtomRadiantStatusBarView = require '../lib/atom-radiant-player-status-bar-view'
{WorkspaceView} = require 'atom'

describe "AtomRadiantStatusBarView", ->
  beforeEach ->
    atom.workspaceView = new WorkspaceView

    waitsForPromise ->
      atom.packages.activatePackage('atom-radiant-player')

  describe "when rocking out", ->
    it "renders the current song's info", ->
      runs ->
        statusBar = atom.workspaceView.statusBar
        setTimeout =>
          expect(statusBar.find('a.atom-radiant-player-status').text()).toBe ''
        , 500

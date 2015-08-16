radiant = require './radiant-node-applescript'

Number::times = (fn) ->
  do fn for [1..@valueOf()] if @valueOf()
  return

class AtomRadiantStatusBarView extends HTMLElement
  initialize: () ->
    @classList.add('radiant-player', 'inline-block')

    div = document.createElement('div')
    div.classList.add('radiant-player-container')

    @soundBars = document.createElement('span')
    @soundBars.classList.add('radiant-player-sound-bars')
    @soundBars.data = {
      hidden: true,
      state: 'paused'
    }

    5.times =>
      soundBar = document.createElement('span')
      soundBar.classList.add('radiant-player-sound-bar')
      @soundBars.appendChild(soundBar)

    div.appendChild(@soundBars)

    @trackInfo = document.createElement('span')
    @trackInfo.classList.add('track-info')
    @trackInfo.textContent = ''
    div.appendChild(@trackInfo)

    @appendChild(div)

    atom.commands.add 'atom-workspace', 'atom-radiant-player:next', => radiant.next => @updateTrackInfo()
    atom.commands.add 'atom-workspace', 'atom-radiant-player:previous', => radiant.previous => @updateTrackInfo()
    atom.commands.add 'atom-workspace', 'atom-radiant-player:playPause', => radiant.playPause => @updateTrackInfo()

    atom.config.observe 'atom-radiant-player.showEqualizer', (newValue) =>
      @toggleShowEqualizer(newValue)

    setInterval =>
      @updateTrackInfo()
    , 5000

  updateTrackInfo: () ->
    radiant.isRunning (err, isRunning) =>
      if isRunning
            radiant.getTrack (error, track) =>
              if track
                trackInfoText = ""
                if atom.config.get('atom-radiant-player.showPlayStatus')
                  if !atom.config.get('atom-radiant-player.showPlayIconAsText')
                    #trackInfoText = if state.state == 'playing' then '► ' else '|| '
                  else
                    #trackInfoText = if state.state == 'playing' then 'Now Playing: ' else 'Paused: '
                trackInfoText += "#{track.artist} - #{track.name}"

                if !atom.config.get('atom-radiant-player.showEqualizer')
                  if atom.config.get('atom-radiant-player.showPlayStatus')
                    trackInfoText += " ♫"
                  else
                    trackInfoText = "♫ " + trackInfoText

                @trackInfo.textContent = trackInfoText
              else
                @trackInfo.textContent = ''
              @updateEqualizer()
      else # radiant isn't running, hide the sound bars!
        @trackInfo.textContent = ''


  updateEqualizer: ()->
    radiant.isRunning (err, isRunning)=>
        return if err
        #@togglePauseEqualizer state.state isnt 'playing'


  toggleShowEqualizer: (shown) ->
    if shown
      @soundBars.removeAttribute 'data-hidden'
    else
      @soundBars.setAttribute 'data-hidden', true

  togglePauseEqualizer: (paused) ->
    if paused
      @soundBars.setAttribute 'data-state', 'paused'
    else
      @soundBars.removeAttribute 'data-state'

module.exports = document.registerElement('status-bar-radiant-player',
                                          prototype: AtomRadiantStatusBarView.prototype,
                                          extends: 'div');

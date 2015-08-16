--I haven't touched this file yet. It may not be necessary since Radiant provides none of this data

tell application "Radiant Player"
  set cstate to "{"
  set cstate to cstate & "\"track_id\": \"" & current track's id & "\""
  set cstate to cstate & ",\"volume\": " & sound volume
  set cstate to cstate & ",\"position\": " & (player position as integer)
  set cstate to cstate & ",\"state\": \"" & player state & "\""
  set cstate to cstate & "}"

  return cstate
end tell

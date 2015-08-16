on escape_quotes(string_to_escape)
  set AppleScript's text item delimiters to the "\""
  set the item_list to every text item of string_to_escape
  set AppleScript's text item delimiters to the "\\\""
  set string_to_escape to the item_list as string
  set AppleScript's text item delimiters to ""
  return string_to_escape
end escape_quotes

tell application "Radiant Player"
  set ctrack to "{"
  set ctrack to ctrack & "\"artist\": \"" & my escape_quotes(current song artist) & "\""
  set ctrack to ctrack & ",\"album\": \"" & my escape_quotes(current song album) & "\""
  set ctrack to ctrack & ",\"name\": \"" & my escape_quotes(current song name) & "\""
  set ctrack to ctrack & "}"
end tell

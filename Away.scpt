global okflag
set okflag to false
set front_app to (path to frontmost application as Unicode text) -- So we can switch back to this after running the fade
 
-- check if iTunes is running
  tell application "System Events"
        if process "iTunes" exists then
                set okflag to true --iTunes is running
        end if
end tell
 
if okflag is true then
  try
    tell application "iTunes"
      set currentvolume to the sound volume
      if (player state is playing) then
        repeat
          --Fade down
          repeat with i from currentvolume to 0 by -1 --try by -4 on slower Macs
            set the sound volume to i
            delay 0.05 -- Adjust this to change fadeout duration (delete this line on slower Macs)
          end repeat
          pause
          --Restore original volume
          set the sound volume to currentvolume
          exit repeat
        end repeat
        set comment of current track to "Proximity Paused"
      end if
    end tell
    tell application front_app
      activate
    end tell
  on error
    beep
  end try
end if

delay 1

-- Set Skype status
tell application "System Events"
	set skype_running to (exists process "Skype")
end tell
if skype_running is true then
	tell application "Skype"
		send command "SET USERSTATUS OFFLINE" script name "AppleScript status setter"
	end tell
end if

-- Set Adium status
tell application "System Events"
     set adium_running to (exists process "Adium")
end tell
if adium_running then
     tell application "Adium" to go away with message "I am away from my computer"
end if

end run
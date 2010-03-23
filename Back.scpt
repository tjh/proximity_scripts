-- Disable the screen Saver Password
do shell script "defaults -currentHost write com.apple.screensaver askForPassword -int 0; ~/notif"
-- Turn OFF the screen saver
tell application "ScreenSaverEngine" to quit

-- Set Adium status
-- tell application "System Events"
--    set adium_running to (exists process "Adium")
-- end tell
-- if adium_running then
--    tell application "Adium" to go available
-- end if

-- Set Skype status
-- tell application "System Events"
-- 	set skype_running to (exists process "Skype")
-- end tell
-- if skype_running is true then
-- 	tell application "Skype"
-- 		send command "SET USERSTATUS ONLINE" script name "AppleScript status setter"
-- 	end tell
-- end if

say "Welcome" using "Zarvox"

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
      if comment of current track is "Proximity Paused" then
        set comment of current track to ""
        play
        repeat with j from 0 to currentvolume by 1 --try by 4 on slower Macs
          set the sound volume to j
          delay 0.05 -- Adjust this to change fadeout duration (delete this line on slower Macs)
        end repeat
      end if
    end tell
    tell application front_app
      activate
    end tell
  on error
    beep
  end try
end if

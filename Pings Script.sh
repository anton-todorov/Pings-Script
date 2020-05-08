 #!/bin/sh
 
 #bash -c "ping 192.168.1.1"
 
  osascript <<-eof
	on run
	
	tell application "Finder"
		set DesktopBounds to bounds of window of desktop
		set DesktopWidth to item 3 of DesktopBounds
		set DesktopHeight to item 4 of DesktopBounds
	end tell
	
	set PingDestination to {"192.168.1.14", "192.168.3.14", "192.168.4.14", "192.168.5.14", "192.168.7.14", "192.168.0.1", "192.168.6.1", "192.168.8.1", "192.168.13.1", "192.168.190.10"}
	
	set TheIncrementValueX to 445
	set TheStartingValueX to 0
	set NumberOfTerminalWindowsOnARowX to (DesktopWidth div TheIncrementValueX) as integer
	set TheEndingValueX to (NumberOfTerminalWindowsOnARowX * TheIncrementValueX)
	
	set TheIncrementValueY to 100
	set TheStartingValueY to 22
	set TheEndingValueY to (DesktopHeight - TheIncrementValueY)
	
	set i to 1
	
	tell application "Terminal"
		activate
		
		repeat with TheIncrementValueY from TheStartingValueY to TheEndingValueY by TheIncrementValueY
			repeat with TheIncrementValueX from TheStartingValueX to TheEndingValueX by TheIncrementValueX
				
				set theCurrentDestination to item i of PingDestination
				set newTab to do script "ping " & theCurrentDestination
				
				set current settings of newTab to settings set "Homebrew"
				set the number of columns of window 1 to 63
				set the number of rows of window 1 to 5
				
				set position of the first window to {TheIncrementValueX, TheIncrementValueY}
				
				set i to (i + 1)
				
				if (i > (count of PingDestination)) then
					exit repeat
				end if
				
			end repeat
			
			if (i > (count of PingDestination)) then
				exit repeat
			end if
			
		end repeat
		
	end tell
	
end run
eof


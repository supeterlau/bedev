set someFolder to path to desktop
log someFolder -- log in Log Hstory

set val to 123
do shell script "echo The value: " & val

tell application "System Events"
	set someItem to first item of someFolder
	log someItem
	set volumeSettings to get volume settings
	set volumeValue to (output volume of volumeSettings)
	set fadeTime to 10 -- time in seconds for fade change
	set fadeChange to (volumeValue div fadeTime)
	-- display alert "Volume: " & volumeValue & ", Delta: " & fadeChange
	display dialog "Sleep time (min):" default answer "25"
	-- delay ((text returned of the result) * 60 - 30)
	delay 5
	display notification "Going to sleep in 30 sec" with title "Sleep Timer"
	-- delay (30 - fadeTime)
	delay 5
	repeat with X from 1 to fadeTime
		set volumeValue to (volumeValue - fadeChange)
		set volume output volume volumeValue
		delay 1
	end repeat
	tell application "Finder"
		set frontmost to true
		display dialog "Fine"
	end tell
	-- sleep -- alternatively: do shell script "pmset sleepnow"
end tell

(*
tell application "Finder"
	set frontmost to true
	display dialog "Fine"
end tell
*)

(*
tell application "foobar2000"
	activate
	tell application "System Events" to key code 49
end tell
*)



(*
tell application "System Events" to tell process "foobar2000"
	set frontmost to true
	tell menu bar item "Playback" of menu bar 1
		click
		click menu item "Pause" of menu 1
	end tell
	set visible to false
end tell
*)



(*
tell application "System Events" to tell process "Finder"
	set frontmost to true
	tell menu bar item "File" of menu bar 1
		click
		click menu item "Open With" of menu 1
	end tell
end tell
*)

(*
tell application "foobar2000"
	-- insert actions here
end tell
*)
use AppleScript version "2.4"
use scripting additions
use framework "Foundation"
use framework "AppKit"

property StatusItem : missing value
property selectedMenu : "" -- each menu action will set this to a number, this will determin which IP is shown

property theDisplay : ""
property defaults : class "NSUserDefaults"

-- check we are running in foreground - YOU MUST RUN AS APPLICATION. to be thread safe and not crash
if not (current application's NSThread's isMainThread()) as boolean then
	display alert "This script must be run from the main thread." buttons {"Cancel"} as critical
	error number -128
end if

-- create an NSStatusBar
on makeStatusBar()
	set bar to current application's NSStatusBar's systemStatusBar
	
	set StatusItem to bar's statusItemWithLength:-1.0
	
	-- set up the initial NSStatusBars title
	StatusItem's setTitle:"IP"
	set newMenu to current application's NSMenu's alloc()'s initWithTitle:"Custom"
	set internalMenuItem to current application's NSMenuItem's alloc()'s initWithTitle:"Internal" action:"showInternal:" keyEquivalent:""
	set externalMenuItem to current application's NSMenuItem's alloc()'s initWithTitle:"External" action:"showIExternal:" keyEquivalent:""
	
	StatusItem's setMenu:newMenu
	newMenu's addItem:internalMenuItem
	newMenu's addItem:externalMenuItem
	internalMenuItem's setTarget:me
	externalMenuItem's setTarget:me
end makeStatusBar

--Show Internal ip Action
on showInternal:sender
	
	
	defaults's setObject:"1" forKey:"selectedMenu"
	my runTheCode()
end showInternal:

--Show External ip Action
on showIExternal:sender
	
	
	defaults's setObject:"2" forKey:"selectedMenu"
	my runTheCode()
end showIExternal:

-- update statusBar
on displayIP(theDisplay)
	StatusItem's setTitle:theDisplay
end displayIP

on runTheCode()
	
	set stringAddress to ""
	--use NSHost to get the Internal IP address 
	set inIPAddresses to current application's NSHost's currentHost's addresses
	
	--work through each item to find the IP
	repeat with i from 1 to number of items in inIPAddresses
		set anAddress to (current application's NSString's stringWithString:(item i of inIPAddresses))
		set ipCheck to (anAddress's componentsSeparatedByString:".")
		set the Counter to (count of ipCheck)
		
		if (anAddress as string) does not start with "127" then
			if Counter is equal to 4 then
				set stringAddress to anAddress
				-- found a match lets exit the repeat
				exit repeat
			end if
		else
			set stringAddress to "Not available"
		end if
	end repeat
	
	-- Get extenal IP
	
	set anError to missing value
	set iPURL to (current application's NSURL's URLWithString:"http://ipecho.net/plain")
	
	set NSUTF8StringEncoding to 4
	set exIP to (current application's NSString's stringWithContentsOfURL:iPURL encoding:NSUTF8StringEncoding |error|:anError) as string
	if exIP contains missing value then
		set exIP to "Not available"
	end if
	
	set selectedMenu to (defaults's stringForKey:"selectedMenu") as string
	if selectedMenu is "" or selectedMenu contains missing value then
		set selectedMenu to "1"
	end if
	
	if selectedMenu is "1" then
		set theDisplay to "Intl: " & stringAddress
	else if selectedMenu is "2" then
		set theDisplay to " Extnl: " & exIP
	end if
	
	--call to update statusBar
	my displayIP(theDisplay)
	
	
end runTheCode

--repeat run  update code
on idle
	
	my runTheCode()
	--my displayIP(theDisplay)
	
	return 30 -- run every 30 seconds
	
end idle
-- call to create initial NSStatusBar
set defaults to current application's NSUserDefaults's standardUserDefaults
my makeStatusBar()

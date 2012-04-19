---
layout: default
title: Reopen All Safari Windows On Login
---

<!--
Title: Reopen-All-Safari-Windows-On-Login
Timestamp: 2011-04-19 17:18:32 +0000
Last Accessed: 2001-01-01 02:01:01 +0000
Times Accessed: 0
Tags: Applescript, Safari
Metadata: 
-->

>%hdrrelated%
> # Related #
> * [[Blog-Archive]]
> * [[Mac_OSX]]
> * [[Safari]]
> * [[Applescript]]
> * [[SyntaxHighlighter]]


__Safari__ provides an option to "Reopen All Windows From Last Session" under the "History" menu, but unfortunately does not allow one to automate this upon startup.  

Selecting this menu item after every system restart was becoming a little tiring, and so I wrote the following Applescript to take care of it for me.  When run, this script simply tells __Safari__ to activate this menu item.  

If the script is saved as an application, it can be added to a user's list of "Login Items", accessible through the "System Preferences" > "Accounts".  To save the script as an application, copy-and-paste it into Applescript Editor, then use the "File" menu option "Save as ..", and select __application__ from the "File Format" menu.

In order to use this script, you will need to "Enable access for assistive devices".  Please read the following instructions from [dougscripts.com](http://dougscripts.com/itunes/itinfo/keycodes.php)

> Setting Up System Preferences
> 
> In order for the "System Events" application to use the key code or keystroke commands, you have to enable Mac OS X's accessibility frameworks. To do this, click on the "Universal Access" pane in "System Preferences". At the bottom of the pane is a checkbox setting called "Enable access for assistive devices". Click on the checkbox so the setting is enabled. Close out of System Preferences.

Here is the Applescript:

``` ascript
(*
Purpose: Tells Safari to "Reopen All Windows From Last Session".

Usage: Save this script as an application, and add it to your "Login Items"

In order to use this script, you will need to "Enable access for assistive 
devices".  Please read the following instructions from 
[dougscripts.com](http://dougscripts.com/itunes/itinfo/keycodes.php)

> Setting Up System Preferences
> 
> In order for the "System Events" application to use the key code or keystroke 
> commands, you have to enable Mac OS X's accessibility frameworks. To do this, 
> click on the "Universal Access" pane in "System Preferences". At the bottom of 
> the pane is a checkbox setting called "Enable access for assistive devices". 
> Click on the checkbox so the setting is enabled. Close out of System 
> Preferences.

Author: Stuart J. D. Andrews;
Email: sunny day in nyc at gmail com
Date: March 6, 2011
Environment: Script Editor 2.3; AppleScript 2.1.2; Mac OS X 10.6.7
*)

do_menu("Safari", "History", "Reopen All Windows from Last Session")

on do_menu(app_name, menu_name, menu_item)
	try
		-- bring the target application to the front
		tell application app_name
			activate
		end tell
		tell application "System Events"
			tell process app_name
				tell menu bar 1
					tell menu bar item menu_name
						tell menu menu_name
							click menu item menu_item
						end tell
					end tell
				end tell
			end tell
		end tell
		return true
	on error error_message
		return false
	end try
end do_menu
```




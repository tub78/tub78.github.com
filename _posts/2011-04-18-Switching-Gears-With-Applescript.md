---
layout: post
title: Switching Gears With Applescript
description: 
tags: [Applescript, Safari, MacVim, Skim]
comments: true
analytics: true
TNTitle: Switching-Gears-With-Applescript
TNTimestamp: 2011-04-18 21:07:37 +0000
TNLast Accessed: 2001-01-01 02:01:01 +0000
TNTimes Accessed: 0
TNTags: Applescript, Safari, MacVim, Skim
TNMetadata: 
---


<pre class="action ideaaction">
>%hdrrelated%
> # Related #
> * [[Blog-Archive]]
> * [[Mac_OSX]]
> * [[Safari]]
> * [[Applescript]]
> * [[MacVim]]
> * [[Skim]]
> * [[SyntaxHighlighter]]
</pre>

Occasionally, I use Safari to view a local file.  If it is a PDF, I might want to re-open it in another PDF reader (e.g. Preview or Skim).  If the file is a text file with an extension recognized by my text editor, I might want to open it in my preferred text editor.  This post explains how I accomplish this.

The following Applescript _re-opens a local file_ from the frontmost window of __Safari__ into a second application.  As show below, the second application is __MacVim__.  The script can be easily modified to open files using other applications, for example __Skim__.  This script should be run from the Applescript menu when the document is open-and-frontmost in Safari.

The script assumes that the __URL__ contains the path to a local file, prefixed by `file://`.  There is no testing performed to ensure that the __URL__ represents a local file.  The prefix is removed, and the desired application is told to open the corresponding document.


Installation
: Place the script in `~/Library/Scripts/Applications/Safari/`.  For more detailed installation instructions, visit [how-to-applescript](http://homepage.mac.com/lthompson.22/applescript/how-to.html).

Keyboard Shortcut
: Choose a system-wide keyboard shortcut that will "Move focus to status menus in the menu bar".  This can be set up in the "Keyboard & Mouse" System Preferences.


Ideally, this script should be extended 

 1. to perform simple tests on the format of the __URL__, and
 1. to attempt to download a remote file before trying to open it locally


{% highlight applescript %}
(*
Purpose: Use this script to re-open using "MacVim" a document that is open in
"Safari".  The script detects the full path of the local file and re-opens it.
Ideally, the script would also close the file in "Safari", but this has not
been implemented.  

Usage: This script should be run from the applescript menu when the document is
open-and-frontmost in Safari.

Installation: Place the script in ~/Library/Scripts/Applications/Safari/  To
access this script, make sure to select "Show script menu in menu bar" in the
AppleScript Utility application (10.5) or in Preferences &gt; General of the
AppleScript Editor application (10.6).

Installation for mouse and trackpad-free access:  Choose a keyboard shortcut
that will "Move focus to status menus in the menu bar".  This can be set up in
the "Keyboard & Mouse" System Preferences.

Author: Stuart J. D. Andrews;
Email: sunny day in nyc at gmail com
Date: April 15, 2011
Environment: Script Editor 2.3; AppleScript 2.1.2; Mac OS X 10.6.7

*)

property myapp : "Safari"
property debug : false
-- property debug : true

try
	set front_process to application "Finder"
	--
	tell application "Safari"
		set VVV to URL of document 1
	end tell
	
	-- remove leading "file://"
	do shell script "echo " & quoted form of VVV & "| cut -c 8-"
	set VVV to result
	errmsg(VVV, front_process)
	
	-- open file in Skim
	tell application "MacVim"
		activate
		open VVV
	end tell
	
	
on error the error_message number the error_number
	errmsg("Error: " & the error_number & ". " & the error_message, front_process)
	
end try


on errmsg(VVV, active_process)
	if debug then
		tell active_process
			activate
			display dialog "Value: " & VVV buttons {"OK"} default button 1
		end tell
	end if
end errmsg

{% endhighlight %}



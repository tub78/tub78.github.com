---
layout: post
title: Convert To Pdf From The Cmdline
description: Convert Files (.doc, .ppt, .txt, etc.) To Pdf From The Cmdline
tags: [CmdLine, GoogleCL, Bash, Pdf]
comments: true
analytics: true
TNTitle: Cmdline-Convert-Word-Doc-2-Pdf
TNTimestamp: 2001-01-01 01:01:01 -0100
TNLast Accessed: 2001-01-01 01:01:01 -0100
TNTimes Accessed: 0
TNTags: CmdLine, GoogleCL, Bash, Pdf
TNMetadata: 
---



<pre class="action ideaaction">
>%hdrrelated%
># Related
> * [[Blog-Archive]]
> * [[Blogging-From-The-Command-Line]]
> * [[Cmdline-Blogging-With-Images]]
> * [[GoogleTools]]
</pre>

Have you ever been in need of a convenient way to convert a Word document (.doc) into a Portable Document Format (.pdf)?

I do this fairly often, which prompted me to write this script using Google Docs.

It works by uploading the input file to a collection named "GDocs2Pdf" in your Google Docs account, and then requesting a Pdf version for download.  If conversion is successful, the filename will have a .pdf extension appended and will be downloaded to the directory containing the input file.

Once installed and placed on your path, simply type `gdocs2pdf.sh example-file.doc` to run the script.

While I regularly use this script to convert Word documents to Pdf, other input formats are acceptable.  Also, by modifying the `--format=pdf` argument on line 11, you can request alternative output file formats.  Log into your Google Docs account to see which input and output formats are currently supported.


<!-- more -->

### Requirements

1. A Google Docs account
1. A collection named "GDocs2Pdf" in your account
1. The _GoogleCL_ command line utility installed^(1,2) on your system
1. A connection to the internet

### Installation

1. Paste the script into a file named "gdocs2pdf.sh"
1. Modify the path to the _GoogleCL_ utility on line 7 as appropriate
1. Place it on your path, for example in your `~/bin` directory
1. Make it executable `chmod u+x gdocs2pdf.sh`

### Script: gdocs2pdf.sh

Please check [https://github.com/tub78/GDocs2Pdf](https://github.com/tub78/GDocs2Pdf) for updates to this script.

``` bash
  #!/bin/bash
  # usage: gdocs2pdf.sh <file>
  [ $# -eq 1 ] || { echo "usage: $(basename $0) <file>"; exit 1; }
  TITLE=$(basename "$1")
  DIR=$(dirname "$1")
  FOLDER=GDocs2Pdf
  GOOGLECL=/usr/local/bin/google
  echo $GOOGLECL docs upload --title="$TITLE" --folder="$FOLDER" "$1"
  $GOOGLECL docs upload --title="$TITLE" --folder="$FOLDER" "$1"
  echo $GOOGLECL docs get --format=pdf --title="$TITLE" --folder="$FOLDER" --dest="$DIR"
  $GOOGLECL docs get --format=pdf --title="$TITLE" --folder="$FOLDER" --dest="$DIR"
```

__Notes__

[1]
: [[_GoogleCL_ webpage](http://code.google.com/p/googlecl/)].  The utility is written in Python.  Please see this page for installation instructions.

[2]
: Configuration of _GoogleCL_ is required to authorize access to your account.  Configuration settings are initialized upon the first invocation of the tool, whether they are supplied as command line arguments or as answers to the interactive prompts.  These defaults are used unless overridden using the flagged arguments.  To change the defaults, see [[Configuration Options](http://code.google.com/p/googlecl/wiki/ConfigurationOptions)].





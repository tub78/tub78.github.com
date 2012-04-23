---
layout: post
title: Bash Syntax Highlighter Example
description: 
tags: [Javascript, Html, CmdLine]
comments: true
analytics: true
TNTitle: SyntaxHighlighterBash
TNTimestamp: 2011-02-01 20:36:43 +0000
TNLast Accessed: 2001-01-01 02:01:01 +0000
TNTimes Accessed: 0
TNTags: Javascript, Html, CmdLine
TNMetadata: 
---


<pre class="action ideaaction">
>%hdrrelated%
># Related #
> * [[Blog-Archive]]
> * [[SyntaxHighlighter]]
> * [[Javascript]]
</pre>

This bash script is from Alex Gorbatchev's [page](http://alexgorbatchev.com/SyntaxHighlighter/).

{% highlight bash %}
#!/bin/bash
X=3
Y=4
empty_string=""
if [ $X -lt $Y ]  # is $X less than $Y ? 
then
  echo "\$X=${X}, which is smaller than \$Y=${Y}"
fi
 
if [ -n "$empty_string" ]; then
  echo "empty string is non_empty"
fi
 
if [ -e "${HOME}/.fvwmrc" ]; then             # test to see if ~/.fvwmrc exists
  echo "you have a .fvwmrc file"
  if [ -L "${HOME}/.fvwmrc" ]; then       # is it a symlink ?  
      echo "it's a symbolic link"
  elif [ -f "${HOME}/.fvwmrc" ]; then     # is it a regular file ?
      echo "it's a regular file"
  fi
else
  echo "you have no .fvwmrc file"
fi
{% endhighlight %}

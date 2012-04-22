---
layout: post
title: Syntax Highlighter
TNTitle: SyntaxHighlighter
TNTimestamp: 2011-02-02 01:31:56 +0000
TNLast Accessed: 2001-01-01 02:01:01 +0000
TNTimes Accessed: 0
TNTags: Javascript, Html
TNMetadata: 
---


<pre class="action ideaaction">
>%hdrrelated%
> # Related #
> * [[Blog-Archive]]
> * [[SyntaxHighlighterConfig]]
> * [[SyntaxHighlighterBash]]
> * [[SyntaxHighlighterPython]]
> * [[Dynamic-Web-Content-With-Javascript-And-JQuery]]
> * [[Switching-Gears-With-Applescript]]
> * [[SyntaxHighlighterApplescript]]
> * [[SyntaxHighlighterObjectiveC]]
> * [[SyntaxHighlighterC]]
> * [[SyntaxHighlighterExtras]]
> * [[Javascript]]
> * [[Blog]]
> * [[GoogleTools]]
</pre>


# Overview

Alex Gorbatchev's SyntaxHighlighter is a Javascript program that highlights code on an Html page.  Here are some links:

 * [Main Page](http://alexgorbatchev.com/SyntaxHighlighter/)
 * [Installation](http://alexgorbatchev.com/SyntaxHighlighter/manual/installation.html)
 * [Configuration](http://alexgorbatchev.com/SyntaxHighlighter/manual/configuration/)
 * [Brushes](http://alexgorbatchev.com/SyntaxHighlighter/manual/brushes/)
 * [Hosting](http://alexgorbatchev.com/SyntaxHighlighter/hosting.html)
 * [Download](http://alexgorbatchev.com/SyntaxHighlighter/download/)

Here are some brief instructions on how to use [[SyntaxHighlighter]] that I have transcribed from Alex's page and elsewhere.

# Configuration

To configure [[SyntaxHighlighter]], do the following:

 1. Include stylesheets `shCore.css` and `shThemeDefault.css`
 1. Include Javascript file `shCore.js`
 1. Include one or more syntax files, e.g.: `shBrushJScript.js`, `shBrushPython.js`, `shBrushBash.js`
 1. Call Javascript method `SyntaxHighlighter.all()`

 * For example

{% highlight xml %}
<link rel="stylesheet" type="text/css"  href="styles/shCore.css" />
<link rel="stylesheet" type="text/css"  href="styles/shThemeDefault.css" />
<script type="text/javascript"  src="scripts/shCore.js"></script>
<script type="text/javascript"  src="scripts/shBrushBash.js"></script>
<script type="text/javascript"> SyntaxHighlighter.all() </script>
{% endhighlight %}

# Usage

To use [[SyntaxHighlighter]] to highlight code, do the following:

## Method 1: using the "pre" tag

Enclose the code with `<pre class="brush: SYNTAX">` and `</pre>` tags.

[[SyntaxHighlighter]] looks for `<pre />` tags which have a specially formatted class attribute. The format of the attribute is the same as the CSS style attribute. The only required parameter is brush (see configuration), which should be set as one of the brush aliases.

Advantages:
: Works everywhere, graceful fallback if there are script problems, shows up in all RSS readers as regular `<pre />`

Problems:
: Major issue with this method is that all right angle brackets must be HTML escaped, eg all `<` must be replaced with `&lt;` This will ensure correct rendering.

## Method 2: using the "script" tag

Enclose the code with `<script>` and `</script>` tags.  See website for more advice ...

# Hosting

[[SyntaxHighlighter]] can be hosted locally, from files on your computer, or remotely, from a servers.  The following is an example of remote hosting:

{% highlight xml %}
<link rel="stylesheet" type="text/css"  href="http://alexgorbatchev.com/pub/sh/current/styles/shCore.css" />
<link rel="stylesheet" type="text/css"  href="http://alexgorbatchev.com/pub/sh/current/styles/shThemeDefault.css" />
<script type="text/javascript"  src="http://alexgorbatchev.com/pub/sh/current/scripts/shCore.js"></script>
<script type="text/javascript"  src="http://alexgorbatchev.com/pub/sh/current/scripts/shBrushBash.js"></script>
<script type="text/javascript"> SyntaxHighlighter.all() </script>
{% endhighlight %}

# Syntax Brushes

In addition to the table below, several other syntaxes are supported

 * [List of brushes - Under My Hat](http://www.undermyhat.org/blog/2009/09/list-of-brushes-syntaxhighligher/)
 * [Applescript brush - David Chambers](http://davidchambersdesign.com/applescript-syntax-highlighting/)
 * [ObjectiveC brush - Geoffrey Bryers, Youngjin Shin](http://www.undermyhat.org/blog/wp-content/uploads/2009/09/shBrushObjectiveC.js)

| Brush name    | Brush aliases                 | File name            |
|---------------|-------------------------------|----------------------|
| ActionScript3 | as3, actionscript3            | shBrushAS3.js        |
| Bash/shell    | bash, shell                   | shBrushBash.js       |
| ColdFusion    | cf, coldfusion                | shBrushColdFusion.js |
| C#            | c-sharp, csharp               | shBrushCSharp.js     |
| C++           | cpp, c                        | shBrushCpp.js        |
| CSS           | css                           | shBrushCss.js        |
| Delphi        | delphi, pas, pascal           | shBrushDelphi.js     |
| Diff          | diff, patch                   | shBrushDiff.js       |
| Erlang        | erl, erlang                   | shBrushErlang.js     |
| Groovy        | groovy                        | shBrushGroovy.js     |
| JavaScript    | js, jscript, javascript       | shBrushJScript.js    |
| Java          | java                          | shBrushJava.js       |
| JavaFX        | jfx, javafx                   | shBrushJavaFX.js     |
| Perl          | perl, pl                      | shBrushPerl.js       |
| PHP           | php                           | shBrushPhp.js        |
| Plain Text    | plain, text                   | shBrushPlain.js      |
| PowerShell    | ps, powershell                | shBrushPowerShell.js |
| Python        | py, python                    | shBrushPython.js     |
| Ruby          | rails, ror, ruby              | shBrushRuby.js       |
| Scala         | scala                         | shBrushScala.js      |
| SQL           | sql                           | shBrushSql.js        |
| Visual        | Basic	vb, vbnet               | shBrushVb.js         |
| XML           | xml, xhtml, xslt, html, xhtml | shBrushXml.js        |

# Themes

In addition to the default theme, other stylesheets are available; just replace "Default" in `shThemeDefault.css` to one of the following:

 * Default, Django, Eclipse, Emacs, FadeToGrey, MDUltra, Midnight, RDark

# Examples

 * [[SyntaxHighlighterConfig]]
 * [[SyntaxHighlighterBash]]
 * [[SyntaxHighlighterPython]]
 * [[Dynamic-Web-Content-With-Javascript-And-JQuery]]
 * [[SyntaxHighlighterApplescript]]
 * [[SyntaxHighlighterObjectiveC]]

# Advanced Usage

## Blogger Integration

Two blogs, [mlawire](http://mlawire.blogspot.com/2009/07/blogger-syntax-highlighting.html) and [cyberack](http://www.cyberack.com/2007/07/adding-syntax-highlighter-to-blogger.html), were helpful for setting up [[SyntaxHighlighter]] on Blogger.  Essentially, their advice is:

> "Log into your blogspot account, select the "Layout" tab, and then click "Edit HTML."
>
> Click "Download Full Template" to make a backup of your current template.
>
> Make a copy of your template, open it in an editor, and find the &lt;/head&gt; closing tag. Before that tag, add the following:

{% highlight html %}
<!--SYNTAX HIGHLIGHTER BEGINS-->
<link rel="stylesheet" type="text/css"  href="http://alexgorbatchev.com/pub/sh/current/styles/shCore.css" />
<link rel="stylesheet" type="text/css"  href="http://alexgorbatchev.com/pub/sh/current/styles/shThemeDefault.css" />
<script type="text/javascript"  src="http://alexgorbatchev.com/pub/sh/current/scripts/shCore.js" ></script>
<script type="text/javascript"  src="http://alexgorbatchev.com/pub/sh/current/scripts/shBrushCss.js" ></script>
<script type="text/javascript"  src="http://alexgorbatchev.com/pub/sh/current/scripts/shBrushXml.js" ></script>
<script language="javascript">
    SyntaxHighlighter.config.clipboardSwf = "http://alexgorbatchev.com/pub/sh/current/scripts/clipboard.swf";
    SyntaxHighlighter.config.bloggerMode = true;
    SyntaxHighlighter.all();
</script>
<!--SYNTAX HIGHLIGHTER ENDS-->
{% endhighlight %}

Blogger will complain and may not display your code correctly if it is first interpreted as Html.  For example, this can happen if your post contains Html code containing the `<link>` or `<head>` tags.

To include tags within a post, the `<` and `>` characters should be replaced by their html-entity representations: e.g. `<` replaced with `&lt;`





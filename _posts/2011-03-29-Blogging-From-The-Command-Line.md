---
layout: post
title: Blogging From The Command Line
TNTitle: Blogging-From-The-Command-Line
TNTimestamp: 2011-04-14 01:29:30 +0000
TNLast Accessed: 2001-01-01 02:01:01 +0000
TNTimes Accessed: 0
TNTags: CmdLine, Markdown, Discount, GoogleCL, Bash, SyntaxHighlighter
TNMetadata: 
---


<pre class="action ideaaction">
>%hdrrelated%
># Related
> * [[Blog-Archive]]
> * [[SyntaxHighlighter]]
> * [[Cmdline-Blogging-With-Images]]
> * [[GoogleTools]]
</pre>


This note describes how to _blog from the command-line_ and some of my motivations for doing so.

Over the past year or so, I started a knowledge database in the form of a [Wiki](http://en.wikipedia.org/wiki/Wiki) to organize my life and work.  After experimenting with a number of markup languages and compilers, I converged on the [Markdown](http://daringfireball.net/projects/markdown/) language, which is simple and well-supported, and the [Discount](http://www.pell.portland.or.us/~orc/Code/discount/) compiler, which is fast, robust, and has a number of useful extensions.

Blogging is a natural extension of this effort, where I can share bits of knowledge and experience to benefit others and hopefully broaden my horizons.  Using the [Blogger](http://www.blogger.com) platform, I could compile my wiki pages into _Html_, then cut-n-paste them into Blogger's web-based editor.  This process is a little clumsy for my taste, not to mention error prone.  Luckily, I stumbled upon Google Command Line (_GoogleCL_).  This utility provides an interface to several Google services including Docs, Picasa and Blogger.

Using _Markdown_, _Discount_, _GoogleCL_, and some Bash shell scripting, I have developed a 2-step workflow for _blogging from the command-line_, consisting of **compiling** and **publishing**.

<!-- more -->

# Compiling

To begin, I use _Discount^1_ to compile my _Markdown_ pages into _Html_.  It is quite simple to compile a blog entry with _Discount's_ default compiler^2, `markdown`.  However, I decided to use an alternate program included in _Discount's_ distribution, called `theme`.  The `theme` compiler allows me to spice things up a little using a template for my posts^3.  For example, to create a table of contents at the top of each post, my template looks like this^4.

{% highlight html %}
&lt;h1&gt;Contents&lt;/h1&gt;
&lt;?theme toc?&gt;
&lt;?theme body?&gt;
{% endhighlight %}

I could then compile with the command `theme -E -t $PAGETHEME -o $HTMLPOST $MKDPOST`, where I specify a template file with the `-t` flag.  __Update (2011-07-14)__: I have included the `-E` flag to avoid difficulties described in Note #4 below.

If you're like me, your current post will contain links to other posts (e.g. [SyntaxHighlighter]) using the _Markdown_ reference-style^5 link format (e.g. `[SyntaxHighlighter]`).  Reference-style links are a shorthand notation for a URL that is defined elsewhere in the input, like this `[SyntaxHighlighter]: http://blog.domain.name/2011/03/syntaxhighlighter_2123.html`.

This means that, in order to compile my current post, I must supply Blogger's URLs for all linked posts .  To obtain the addresses, I use the following _GoogleCL^6_ command

{% highlight bash %}
#!/bin/bash
MKDINDEX=./Blog/MkdIndex.md
google blogger list --fields title,url | \
    grep -v ",None" | \
    perl -p -e 's#^(.*),(.*)$#\[${1}\]: ${2}#' >| $MKDINDEX
{% endhighlight %}

This invocation of _GoogleCL_ requests a list of posts which are returned as "title,url" pairs.  Post-processing is performed to remove drafts (url="None"), and to format the remaining tuples for _Markdown_.  These are saved to an index file.

Now, I am ready to compile my post.  To do this, I concatenate the source file and the index file and send the result to the compiler.  Here is a script that does this

{% highlight bash %}
#!/bin/bash
DISCOUNTTHEME=/usr/local/bin/theme
MKDPOST=./Notes/Post.txt
HTMLPOST=./Blog/Post.html
PAGETHEME=./Blog/page.theme
MKDINDEX=./Blog/MkdIndex.md
cat $MKDPOST $MKDINDEX | $DISCOUNTTHEME -E -t $PAGETHEME -o $HTMLPOST
{% endhighlight %}

This creates my post `./Notes/Post.html` containing valid links to other posts.

The benefit of using _GoogleCL_ to retrieve the urls is that we can be confident that they will be up to date and correct.  On the other hand, since _GoogleCL_ can only return urls for existing posts, this method constrains links to be directed in reverse-chronological order; from new posts to existing posts (in mathematical terms, the link structure amongst posts will be a _directed acyclic graph_).  To have two posts link to one another, each post needs to be re-compiled after both have been published.


# Publishing

Publishing a blog entry using _GoogleCL_ is as simple as `google blogger post $HTMLPOST`.  With a little more work, it is also possible to assign a title and tags to the blog post.  Tags are useful for summarizing the page, and for finding related pages.  I typically include these fields in the header of my _Markdown_ files which is enclosed in an _Html_ comment block so that it does not appear in the compiled output.  For example, to tag a page with **tag1** and **tag2** and assign **title** as the title, I would write

{% highlight xml %}
 &lt;!--
 Title: title
 Tags: tag1, tag2
 --&gt;

 Metadata is stored in the header of this page ...
{% endhighlight %}

To publish this blog entry with the associated metadata, I extract it from the header and pass it to the post command using the `--title` and `--tags` flag.  This is what it looks like

{% highlight bash %}
#!/bin/bash
MKDPOST=./Notes/Post.txt
HTMLPOST=./Blog/Post.html
TITLE=$(head -20 $MKDPOST | grep '^Title: ' | cut -b 8-)
TAGS=$(head -20 $MKDPOST | grep '^Tags: ' | cut -b 7-)
google blogger post --title "$TITLE" --tags "$TAGS" $HTMLPOST
{% endhighlight %}

Running this command, _GoogleCL_ should reply

{% highlight text %}
Post created: http://blog.domain.name/2011/03/title.html
{% endhighlight %}

It is important to note that subsequent calls to `google blogger post` will not overwrite the earlier post.  Instead, this will create a near identical post on Blogger differing only by a numeric suffix added to the URL.  If a correction to a post is necessary, then one solution is to resort to the manual cut-n-paste method using Blogger's web-based Html editor, after compiling the corrected post.  Another solution (for the tech-savvy only) is to use a patched version of _GoogleCL_ [patch](http://code.google.com/p/googlecl/issues/detail?id=260).

That's it!  I've demonstrated the essential commands to **compile** and **publish** posts to Blogger.  Wrapped in a convenient script, this approach allows one to _blog from the command-line_ with a single carriage-return.

In a future post, I plan to cover an extension that allows inclusion of images.


__Notes__
[1]
: _Discount_ is installed under `/usr/local/bin/` after buiding with the command `make install.everything` as per the [INSTALL](https://github.com/Orc/discount/blob/master/INSTALL) file.

[2]
: This is accomplished by `markdown -o $HTMLPOST $MKDPOST`, where `-o` specifies the output file.

[3]
: See the _Discount_ documentation to learn about templates for `theme`.

[4]
: ~~I made a small change to the `theme` executable to support the template that I am using.  In particular, the program will only include the body content within _Html_ body tags.  Since body tags are not necessary for uploads into Blogger, I commented line 468 of `theme.c` as follows, before installing _Discount_.  This probably isn't be necessary, however, in this case your template will require `<body>` and `</body>` tags.~~  The author of Discount has now added a flag `-E` that obviates the need for this.  **Yay for DVCS!**

{% highlight c++ %}
/* if ( keyword[i].where & where ) */
{% endhighlight %}

[5]
: Formally, reference-style links are declared using the syntax `[Link-text][Link-name]`, however `[Link-text][]` and even `[Link-text]` may be used as shorthand if "Link-text" meets the _Markdown_ requirements for the link name.  This is called the _implicit link name_ shortcut.

[6]
: Proper _GoogleCL_ configuration is required.  The Google Command Line utility records configuration defaults on its first invocation, whether they are supplied as command line arguments or as answers to the interactive prompts.  These defaults are used unless overridden using the flagged arguments.  This makes subsequent invocations of the utility less onerous.  For example, my usage above omits the `--blog` flag, because my setting is recorded in my configuration file.  To change the defaults, see [Configuration Options](http://code.google.com/p/googlecl/wiki/ConfigurationOptions).




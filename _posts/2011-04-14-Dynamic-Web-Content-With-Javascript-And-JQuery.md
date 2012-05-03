---
layout: post
title: Dynamic Web Content With Javascript And JQuery
description: 
tags: [Html, Javascript]
comments: true
analytics: true
TNTitle: Dynamic-Web-Content-With-Javascript-And-JQuery
TNTimestamp: 2011-04-14 18:45:41 +0000
TNLast Accessed: 2001-01-01 02:01:01 +0000
TNTimes Accessed: 0
TNTags: Html, Javascript
TNMetadata: 
---


<pre class="action ideaaction">
>%hdrrelated%
># Related
> * [[Blog-Archive]]
> * [[SyntaxHighlighter]]
> * [[Javascript]]
</pre>


This post describes how to use Javascript to create dynamic web content.

## Example: Changing Appearances

It is relatively simple to enhance a webpage with interactive features.  For example, this post contains buttons that change its appearance.  Click the "Help" button to learn more.

The purpose of this post is to demonstrate a simple method of transforming a static page into one that is dynamic.

The buttons and their actions are implemented via a combination of Html, CSS and Javascript.  Cascading stylesheets are used to define the attributes of Html elements in each state.  Javascript enables dynamic content by changing the style attributes of various Html elements on the page.

The code segments necessary to recreate these dynamic elements are explained below.

<hr>
<span style="font-size:1.2em">Appearance:</span>
<button id="daynight" style="float:none">Day/Night</button>
<span style="font-size:1.2em">Visibility:</span>
<button id="optional" style="float:none">Show/Hide</button>

<div class="optional">
<hr>
<ol>
<li> Appearance<br /> Toggle appearance of blog by pressing the button </li>
<li> Visibility<br /> Toggle visibility of this text by pressing the button </li>
</li>
</ol>
</div>
<hr>

## Html

The Html code for the page is fairly simple.  In the header

1. A `style` tag is used to include the CSS stylesheet.
1. A `script` tag is used to include the JQuery library, which is used by Javascript.
1. A `script` tag is used to define the Javascript.

In the body, there is

1. A "Help" `button` with ID equal to `optional`
1. A "Day/Night" `button` with ID equal to `daynight`
1. A `div` element containing instructions with class equal to `optional`

``` xml
  <!doctype html>
  <!-- !doctype html public "-//W3C//DTD HTML 4.0 Transitional //EN"> -->
  <html>
  <head>
      <!-- STYLESHEET -->
      <style type="text/css">
          /* insert stylesheet here */
      </style>

      <!-- JAVASCRIPT -->
      <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
      <script language="javascript">//<![CDATA[
          /* insert js code here */
      //]]></script>
  </head>
  <body>

  <button id="optional">Help</button>
  <button id="daynight">Day/Night</button>
  <div class="optional">
  <h1>Buttons</h1>
   * Toggle visibility of this text by pressing the "Help" button
   * Toggle appearance by pressing the "Day/Night" button
  </div>
  </body>
  </html>
```

## Stylesheet

The style of Html elements is specified in a stylesheet included in the header.  There are separate styles `day` and `night` for the `<body>` tag.  These styles alter the foreground (text) and background colors.  Elements with class `optional` are initialized to be invisible `display: none`.

``` css
  body { /* static body style: e.g. margins, font, etc. */
  }
  body.day { /* day body style */
      color: #000000;
      background-color: #FFFFFF;
  }
  body.night { /* night body style */
      color: #AAAAAA;
      background-color: #191919;
  }
  .optional {
      display: none;
  }
```


## Javascript

The response to button clicks is governed by Javascript, written with the help of the JQuery library that was included in the header.  In this script:

1. JQuery code is included in the document's `ready()` function.  This ensures that the script is activated after the page has completed loading.
1. In line 3, JQuery defines a function that is called when the button with ID equal to `optional` is clicked.
1. Within this function, on line 4, JQuery is used to toggle the visibility of div elements with class equal to `optional`.
1. Lines 8-13 initialize the CSS classes for the `<body>` tag.  If it is daytime, the CSS style `body.day` is used; for nighttime, the CSS style `body.night` is used.
1. In lines 15-18, JQuery is used to toggle the classes for the same elements.  The instantiated styles are removed by one of the `toggle()` commands, and the alternate styles are included by the other.

``` javascript
  $(document).ready(function(){
      /* Toggle visibility of element */
      $("button#optional").click(function(){
          $("div.optional").toggle();
      });

      /* Display day mode between 7am and 7pm */
      var currentTime = new Date().getHours();
      if (7 <= currentTime && currentTime < 19) {
          $("body").addClass("day");
      } else {
          $("body").addClass("night");
      }

      $("button#daynight").click(function(){
          $("body").toggleClass("day");
          $("body").toggleClass("night");
      });

  });
```


## Wrap Up

That's about it.

Clicking the "Help" button activates the click function on line 3, toggling the visibility of the instructions, and clicking the "Day/Night" button activates the click function on line 15, changing the background/foreground colors of the page.

Have fun experimenting with Html, CSS and Javascript.





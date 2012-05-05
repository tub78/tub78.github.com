/*!
 * Main callback script
 */
$(document).ready(function(){
  // Display day mode between 7am and 8pm
  var currentTime = new Date().getHours();
  var daytime_selected = (7 <= currentTime && currentTime < 19) ? 'yes' : 'no';
  daytime_selected = $.cookie('tub78_daytime_selected') || daytime_selected;
  if (daytime_selected == 'yes') {
    $(".title,.todoaction,.ideaaction,.bugaction,.doneaction,body,h1,h2,h3,h4,h5,h6,a,a.missing-wiki-link,th,blockquote,code").addClass("day");
  } else {
    $(".title,.todoaction,.ideaaction,.bugaction,.doneaction,body,h1,h2,h3,h4,h5,h6,a,a.missing-wiki-link,th,blockquote,code").addClass("night");
  }
  $.cookie('tub78_daytime_selected', daytime_selected, { expires: 1, path: '/' });
  $("button#daynight").click(function(){
    $(".title,.todoaction,.ideaaction,.bugaction,.doneaction,body,h1,h2,h3,h4,h5,h6,a,a.missing-wiki-link,th,blockquote,code").toggleClass("day");
    $(".title,.todoaction,.ideaaction,.bugaction .doneaction,body,h1,h2,h3,h4,h5,h6,a,a.missing-wiki-link,th,blockquote,code").toggleClass("night");
    var daytime_selected = $.cookie('tub78_daytime_selected') || 'yes';
    $.cookie('tub78_daytime_selected', (daytime_selected == 'yes') ? 'no' : 'yes', { expires: 1, path: '/' });
  });

  /* Toggle visibility of 'help' button */
  $("button#optional").click(function(){
      $("div.optional").toggle();
  });
});


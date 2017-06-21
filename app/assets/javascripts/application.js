// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require debounce.min
//= require bootstrap.min
//= require turbolinks
//= require snap.min
//= require toastr
//= require jquery.matchHeight-min
//= require ie10-viewport-bug-workaround
//= require morphdom
//= require background-check.min

// 'use strict';

Turbolinks.SnapshotRenderer.prototype.assignNewBody = function() {
  return morphdom(document.body, this.newBody, {});
};

var turbolinks_go = function(url, no_scroll){
  var scroll;
  if(no_scroll){
    function getScroll(){
      scroll = $(document).scrollTop();
    }
    function scrollPage(){
      $(document).scrollTop(scroll);
      removeEventListener("turbolinks:before-render", getScroll, false);
      removeEventListener("turbolinks:render", scrollPage, false);
    }
    addEventListener("turbolinks:before-render", getScroll, false);
    addEventListener("turbolinks:render", scrollPage, false);
  }
  Turbolinks.clearCache();
  Turbolinks.visit(url);
}

function getContrastYIQ(hexcolor){
  if(hexcolor){
    var new_hex = hexcolor.replace('#','');
    var r = parseInt(new_hex.substr(0,2),16);
    var g = parseInt(new_hex.substr(2,2),16);
    var b = parseInt(new_hex.substr(4,2),16);
    var yiq = ((r*299)+(g*587)+(b*114))/1000;
    return (yiq >= 128) ? '#111' : '#fff';
  }
}

function rgb2hex(rgb) {
  if ( rgb && rgb.search("rgb") == -1 ) {
    return rgb;
  } else if(rgb) {
    rgb = rgb.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+))?\)$/);
    function hex(x) {
        return ("0" + parseInt(x).toString(16)).slice(-2);
    }
    return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
 }
}

function onElementHeightChange(elm, callback){
  // var lastHeight = elm.clientHeight, newHeight;
  // (function run(){
  //     newHeight = elm.clientHeight;
  //     if( lastHeight != newHeight )
  //         callback();
  //     lastHeight = newHeight;
  //
  //     if( elm.onElementHeightChangeTimer )
  //         clearTimeout(elm.onElementHeightChangeTimer);
  //     elm.onElementHeightChangeTimer = setTimeout(run, 400);
  // })();
}

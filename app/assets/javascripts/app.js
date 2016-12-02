// require tinymce-jquery

//= require froala_editor.min.js
//= require plugins/align.min.js
//= require plugins/char_counter.min.js
//= require plugins/code_beautifier.min.js
//= require plugins/code_view.min.js
//= require plugins/colors.min.js
//= require plugins/emoticons.min.js
//= require plugins/entities.min.js
//= require plugins/file.min.js
//= require plugins/font_family.min.js
//= require plugins/font_size.min.js
//= require plugins/fullscreen.min.js
//= require plugins/image.min.js
//= require plugins/image_manager.min.js
//= require plugins/inline_style.min.js
//= require plugins/line_breaker.min.js
//= require plugins/link.min.js
//= require plugins/lists.min.js
//= require plugins/paragraph_format.min.js
//= require plugins/paragraph_style.min.js
//= require plugins/quick_insert.min.js
//= require plugins/quote.min.js
//= require plugins/save.min.js
//= require plugins/table.min.js
//= require plugins/url.min.js
//= require plugins/video.min.js
//= require interact.min
//= require jquery-fileupload/basic
//= require jquery-ui/sortable
//= require evol-colorpicker

'use strict';

var fixScroll = function(opts){
  var fix, top_marker, bottom_market;
  var fix = opts['fix'];
  var top_marker = opts['top_marker'];
  var bottom_market = opts['bottom_market'];
  var body_padding_bottom = parseInt($('body').css('paddingBottom'));
  $(document).on("scroll", function(e) {
    if ($(top_marker).length && ($(this).scrollTop() > $(top_marker).offset().top) && ($(this).scrollTop() < $(bottom_market).offset().top - $(fix).outerHeight())) {
      $(fix).addClass("fixed");
      $(top_marker).css(
        {
          paddingTop: $(fix).outerHeight(),
        }
      );
      $('body').css(
        {
          paddingBottom: body_padding_bottom + $(fix).outerHeight() + 1
        }
      );
      $(fix).css({
        width: $(top_marker).width(),
        boxShadow: '0px 2px 3px rgba(0,0,0,.3)'
      });
    } else {
      $(fix).removeClass("fixed");
      $(fix).css({
        width: $(top_marker).width(),
        boxShadow: 'none'
      });
      $('body').css(
        {
          paddingBottom: body_padding_bottom + 1
        }
      );
      $(top_marker).css({paddingTop: 0});
    }
  });
}


var file_upload_load = function(element, attachable_id, attachable_type, path, id){
  /*jslint unparam: true */
  /*global window, $ */
  // Change this to the location of your server-side upload handler:

  var random_str = Math.random().toString(36).substring(7);
  console.log('file_upload_load');
  console.log(random_str);

  var element_dropzone = $(element + '_dropzone');

  $(element).fileupload({
    dataType: 'script',
    url: id ? path + '/' + id : path,
    type: id ? 'PUT' : 'POST',
    dropZone: element_dropzone,
    forcePlaceholderSize: true,
    multipart: true,
    formData: {"attachable_id": attachable_id, "attachable_type": attachable_type},
    add: function(e, data) {
      var file, types;
      types = /(\.|\/)(gif|jpe?g|png)$/i;
      file = data.files[0];
      if (types.test(file.type) || types.test(file.name)) {
        data.context = $('<div class="' + random_str + '">' + file.name + '</div>');
        $('#files').append(data.context);
        return data.submit();
      } else {
        return alert(file.name + " is not a gif, jpeg, or png image file");
      }
    },
    progress: function(e, data) {
      var progress;
      if (data.context) {
        progress = parseInt(data.loaded / data.total * 100, 10);
        $('.progress').removeClass('hide');
        return $('.progress-bar').css('width', progress + '%');
        console.log(progress)
      }
    },
    complete: function(e, data){
        console.log('done')
        $('.progress-bar').css('width', '0%');
        $('.progress').addClass('hide');
        return $('.' + random_str).remove();
    }
  });

  $(document).bind('dragover', function (e) {
    var dropZone = element_dropzone,
      timeout = window.dropZoneTimeout;
    if (!timeout) {
      dropZone.addClass('in');
    } else {
      clearTimeout(timeout);
    }
    var found = false,
      node = e.target;
    do {
      if (node === dropZone[0]) {
          found = true;
          break;
      }
      node = node.parentNode;
    } while (node != null);
    if (found) {
      dropZone.addClass('hover');
    } else {
      dropZone.removeClass('hover');
    }
    window.dropZoneTimeout = setTimeout(function () {
      window.dropZoneTimeout = null;
      dropZone.removeClass('in hover');
    }, 100);
  });
}

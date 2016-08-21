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
//= require bootstrap.min
//= require turbolinks
//= require ie10-viewport-bug-workaround

var set_summernote = function(){
  var sendFile;
  sendFile = function(file, toSummernote) {
    var data;
    var attachable_id = toSummernote.context.dataset.attachableId
    var attachable_type = toSummernote.context.dataset.attachableType
    data = new FormData;
    data.append('image[asset]', file);
    data.append('image[attachable_id]', attachable_id);
    data.append('image[attachable_type]', attachable_type);
    return $.ajax({
      data: data,
      type: 'POST',
      url: '/images.json',
      cache: false,
      contentType: false,
      processData: false,
      success: function(data) {
        console.log('file uploading...');
        return toSummernote.summernote("insertImage", data.large);
      }
    });
  };


  $('.summernote').each(function(){
    $(this).summernote({
      toolbar: [
          ['style', ['style']],
        ['font', ['bold', 'italic', 'underline', 'clear']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['insert', ['link', 'picture', 'hr']],
        ['view', ['fullscreen','codeview']]
      ],
        styleTags: ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'pre'],
        minHeight: '200px',
      callbacks: {
        onPaste: function (e) {
            var bufferText = ((e.originalEvent || e).clipboardData || window.clipboardData).getData('Text');
            e.preventDefault();
            document.execCommand('insertText', true, bufferText);
        },
        onImageUpload: function(files) {
          return sendFile(files[0], $(this));
        }
      }
    });
  })
}

var setup_affix = function(){
  // affix_offset = $('#about').offset().top;
  // $('.note-toolbar').affix({
  //   offset: {
  //     top: affix_offset
  //   }
  // });
}

var note_affix_toolbar = function(){
  $('.note-toolbar').on('affix.bs.affix', function () {
      $('#about').css('padding-top',$('.note-toolbar').height()+30);
  });
}

var fade_in_alert =  function(){
  $(function() {
    $('#alerts').delay(100).slideDown('normal', function() {
      $(this).delay(5500).slideUp();
    });
  });
}

var document_scrolling = function(){
  // $(document).scroll(function() { //.box is the class of the div
  //   if($(this).scrollTop() > $('#name').offset().top - ($('.note-toolbar').height()+30) || $(this).scrollTop() < $('#about').offset().top ) {
  //     $(window).off('.affix');
  //     $('.note-toolbar').removeData('bs.affix').removeClass('affix affix-top affix-bottom');
  //       $('#about').css('padding-top',0);
  //   }else{
  //     setup_affix();
  //   }
  // });
}

var document_load = function(){
  document.addEventListener("turbolinks:load", function () {
    set_summernote();
    note_affix_toolbar();
    document_scrolling();
    fade_in_alert();
  });
}();


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

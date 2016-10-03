// require tinymce
//= require summernote
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
    var image_random = Math.random().toString(36).substring(7);
    return $.ajax({
      data: data,
      type: 'POST',
      url: '/images.json',
      cache: false,
      contentType: false,
      processData: false,
      beforeSend: function( xhr ) {
        // $('.uploading_image_' + image_random + '').remove();
        console.log('file uploading...');
      },
      success: function(data) {
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



// var sendFile = function(file, input_field, callback) {
//   var data;
//   console.log(input_field);
//   var attachable_id = input_field[0].dataset.attachableId;
//   var attachable_type = input_field[0].dataset.attachableType;
//   data = new FormData;
//   data.append('image[asset]', file);
//   data.append('image[attachable_id]', attachable_id);
//   data.append('image[attachable_type]', attachable_type);
//   $('.mce-container input').prop('disabled', true);
//   $('.mce-container input:first').val('Uploading...');
//   return $.ajax({
//     data: data,
//     type: 'POST',
//     url: '/images.json',
//     cache: false,
//     contentType: false,
//     processData: false,
//     success: function(data) {
//       console.log('file uploading...');
//       $('.mce-container input').prop('disabled', false);
//       return callback(data);
//     },
//     error: function(error){
//       $('.mce-container input').prop('disabled', false);
//       $('.mce-container input').val('');
//       return callback(error);
//     }
//   });
// };
//
//
// var timyMceSetup = function(selector, stylesheet, file_upload_selector){
//   tinyMCE.remove();
//   tinyMCE.init({
//     selector: selector,
//     menubar: false,
//     browser_spellcheck: true,
//     automatic_uploads: true,
//     images_upload_url: 'images.json',
//     //images_upload_base_path: '/images/<%=@current_website.id%>',
//     image_caption: true,
//     autoresize_bottom_margin: 10,
//     theme: 'modern',
//     image_advtab: true,
//     plugins: [
//       'autoresize advlist autolink lists link image charmap print preview hr anchor pagebreak',
//       'searchreplace wordcount visualblocks visualchars code fullscreen',
//       'insertdatetime media nonbreaking save table contextmenu directionality',
//       'emoticons template paste textcolor colorpicker textpattern imagetools'
//     ],
//     imagetools_cors_hosts: ['rethinkwdprod.s3.amazonaws.com', 'rethinkwebdesign.com'],
//     toolbar1: 'file undo redo | styleselect code | bold italic removeformat | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent hr | link image media',
//     image_advtab: true,
//     content_css: [
//       stylesheet
//     ],
//     images_upload_handler: function (blobInfo, success, failure) {
//       var xhr, formData;
//
//       xhr = new XMLHttpRequest();
//       xhr.withCredentials = false;
//       // xhr.open('POST', '/images.json');
//
//       xhr.onload = function() {
//         var json;
//
//         if (xhr.status != 200) {
//           failure('HTTP Error: ' + xhr.status);
//           return;
//         }
//
//         json = JSON.parse(xhr.responseText);
//
//         if (!json || typeof json.location != 'string') {
//           failure('Invalid JSON: ' + xhr.responseText);
//           return;
//         }
//
//         success(json.medium);
//       };
//
//       formData = new FormData();
//       formData.append('file', blobInfo.blob(), blobInfo.filename());
//
//       xhr.send(formData);
//     },
//     file_picker_callback: function(callback, value, meta) {
//       if (meta.filetype == 'image') {
//         $(file_upload_selector).trigger('click');
//         $(file_upload_selector).on('change', function() {
//           var file = this.files[0];
//           sendFile(file, $(file_upload_selector), function(e){
//             if(!e.status || e.status < 299){
//               console.log(e)
//               callback(e.large, {
//                 alt: e.asset_file_name
//               });
//             }else{
//               alert('unable to upload');
//               console.log(e)
//             }
//             $(file_upload_selector).val('');
//           });
//         });
//       }
//     }
//   });
// }

var file_upload_load = function(element, attachable_id, attachable_type){
  /*jslint unparam: true */
  /*global window, $ */
  // Change this to the location of your server-side upload handler:
  $(element).fileupload({
    dataType: 'script',
    url: '/hero_images',
    type: 'POST',
    multipart: true,
    formData: {"hero_image[attachable_id]": attachable_id, "hero_image[attachable_type]": attachable_type},
    add: function(e, data) {
      var file, types;
      types = /(\.|\/)(gif|jpe?g|png)$/i;
      file = data.files[0];
      if (types.test(file.type) || types.test(file.name)) {
        data.context = $('<div>' + file.name + '</div>');
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
    done: function(e, data){
      if (data.context) {
        console.log('done')
        return data.context.remove();
      }
    }
  });
}

document.addEventListener("turbolinks:load", function () {
  set_summernote();
});

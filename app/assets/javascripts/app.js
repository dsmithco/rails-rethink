//= require tinymce
//= require jquery-fileupload/basic
//= require jquery-ui/sortable
//= require evol-colorpicker


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

var sendFile = function(file, input_field, callback) {
  var data;
  console.log(input_field);
  var attachable_id = input_field[0].dataset.attachableId;
  var attachable_type = input_field[0].dataset.attachableType;
  data = new FormData;
  data.append('image[asset]', file);
  data.append('image[attachable_id]', attachable_id);
  data.append('image[attachable_type]', attachable_type);
  $('.mce-container input').prop('disabled', true);
  $('.mce-container input:first').val('Uploading...');
  return $.ajax({
    data: data,
    type: 'POST',
    url: '/images.json',
    cache: false,
    contentType: false,
    processData: false,
    success: function(data) {
      console.log('file uploading...');
      $('.mce-container input').prop('disabled', false);
      return callback(data);
    },
    error: function(error){
      $('.mce-container input').prop('disabled', false);
      $('.mce-container input').val('');
      return callback(error);
    }
  });
};


var timyMceSetup = function(selector, stylesheet, file_upload_selector){
  tinyMCE.remove();
  tinyMCE.init({
    selector: selector,
    menubar: false,
    browser_spellcheck: true,
    automatic_uploads: true,
    // images_upload_base_path: '/images/<%=@current_website.id%>',
    image_caption: true,
    autoresize_bottom_margin: 10,
    theme: 'modern',
    image_advtab: true,
    plugins: [
      'autoresize advlist autolink lists link image charmap print preview hr anchor pagebreak',
      'searchreplace wordcount visualblocks visualchars code fullscreen',
      'insertdatetime media nonbreaking save table contextmenu directionality',
      'emoticons template paste textcolor colorpicker textpattern imagetools'
    ],
    imagetools_cors_hosts: ['rethinkwdprod.s3.amazonaws.com', 'rethinkwebdesign.com'],
    toolbar1: 'file undo redo | styleselect code | bold italic removeformat | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent hr | link image media',
    image_advtab: true,
    content_css: [
      stylesheet
    ],
    file_picker_callback: function(callback, value, meta) {
      if (meta.filetype == 'image') {
        $(file_upload_selector).trigger('click');
        $(file_upload_selector).on('change', function() {
          var file = this.files[0];
          sendFile(file, $(file_upload_selector), function(e){
            if(!e.status || e.status < 299){
              console.log(e)
              callback(e.large, {
                alt: e.asset_file_name
              });
            }else{
              alert('unable to upload');
              console.log(e)
            }
            $(file_upload_selector).val('');
          });
        });
      }
    }
  });
}

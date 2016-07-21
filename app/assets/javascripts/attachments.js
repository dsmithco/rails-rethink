$(function () {
  if($('#logo_uploader').height){
    document.addEventListener("turbolinks:load", function() {
      var logo_uploader = $('#logo_uploader');
      var inlineFormData = logo_uploader.data('formData');
      var url = '/logos';
      var method = 'POST'
      if(inlineFormData.id){
        url = url + '/' + inlineFormData.id;
        method = 'PUT'
      }
      $('#logo_uploader').fileupload({
        dataType: "script",
        url: url,
        multipart: true,
        method: method,
        add: function(e, data) {
          data.formData = inlineFormData;
          var file, types;
          types = /(\.|\/)(gif|jpe?g|png)$/i;
          file = data.files[0];
          if (types.test(file.type) || types.test(file.name)) {
            data.context = $(tmpl("template-upload", file).trim())
            logo_uploader.append(data.context);
            return data.submit();
          } else {
            return alert(file.name + " is not a gif, jpeg, or png image file");
          }
        },
        progress: function(e, data) {
          var progress;
          if (data.context) {
            progress = parseInt(data.loaded / data.total * 100, 10);
            return data.context.find('.progress-bar').css('width', progress + '%');
          }
        },
        done: function(e, data){
          if (data.context) {
            return data.context.hide();
          }
        }
      });
      $('#new_hero_image').fileupload({
        dataType: 'script',
        url: '/hero_images',
        type: 'POST',
        multipart: true,
        add: function(e, data) {
          data.formData = $(this).data('formData');
          var file, types;
          types = /(\.|\/)(gif|jpe?g|png)$/i;
          file = data.files[0];
          if (types.test(file.type) || types.test(file.name)) {
            data.context = $(tmpl("template-upload", file).trim())
            $('.new_hero_image').append(data.context);
            return data.submit();
          } else {
            return alert(file.name + " is not a gif, jpeg, or png image file");
          }
        },
        progress: function(e, data) {
          var progress;
          if (data.context) {
            progress = parseInt(data.loaded / data.total * 100, 10);
            return data.context.find('.progress-bar').css('width', progress + '%');
          }
        },
        done: function(e, data){
          if (data.context) {
            return data.context.hide();
          }
        }
      });
    });
  }
});

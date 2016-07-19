$(function () {
  if($('.edit_logo').height){
    document.addEventListener("turbolinks:load", function() {
      $('.edit_logo').fileupload({
        dataType: "script",
        add: function(e, data) {
          var file, types;
          types = /(\.|\/)(gif|jpe?g|png)$/i;
          file = data.files[0];
          if (types.test(file.type) || types.test(file.name)) {
            data.context = $(tmpl("template-upload", file).trim())
            $('.edit_logo').append(data.context);
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
      $('.new_hero_image').fileupload({
        dataType: "script",
        add: function(e, data) {
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

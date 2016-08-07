//= require summernote
//= require angular
//= require angular-sanitize
//= require ng-file-upload-shim.min
//= require ng-file-upload.min
//= require ng-sortable.min
//= require select.min
//= require jquery-fileupload/basic

document.addEventListener("turbolinks:load", function () {
  angular.bootstrap(document.body, ['app']);
});

angular.module('app', ['ngSanitize','ngFileUpload','as.sortable','ui.select']);
angular
  .module('app')
  .controller('BaseController', BaseController);

function BaseController() {}
BaseController.$inject = ['$scope', '$http', '$timeout'];

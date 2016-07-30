//= require summernote
//= require angular
//= require angular-sanitize
//= require ng-file-upload-shim.min
//= require ng-file-upload.min
//= require ng-sortable.min

document.addEventListener("turbolinks:load", function () {
  angular.bootstrap(document.body, ['app']);
});

angular.module('app', ['ngSanitize','ngFileUpload','as.sortable']);
angular
  .module('app')
  .controller('BaseController', BaseController);

function BaseController() {}
BaseController.$inject = ['$scope', '$http', '$timeout'];

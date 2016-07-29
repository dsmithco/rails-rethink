document.addEventListener("turbolinks:load", function () {
  angular.bootstrap(document.body, ['app']);
});

angular.module('app', ['ngSanitize','ngFileUpload','as.sortable']);
angular
  .module('app')
  .controller('BaseController', BaseController);

function BaseController() {}
BaseController.$inject = ['$scope', '$http', '$timeout'];

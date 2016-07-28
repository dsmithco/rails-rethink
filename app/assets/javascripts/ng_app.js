angular.module('app', ['ngSanitize','ngFileUpload']);

angular
  .module('app')
  .controller('BaseController', BaseController);

BaseController.$inject = ['$scope'];

function BaseController() {}

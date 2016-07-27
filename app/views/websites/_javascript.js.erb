angular.module('app', ['ngSanitize']);

angular
  .module('app')
  .controller('WebsiteController', WebsiteController);

function WebsiteController($scope, $http, Upload, $timeout) {
  var webCtrl = this;

  webCtrl.save_hero = function(hero){
    var url = '/attachments/' + hero.id + '.json';
    $http.put(url, hero).then(function(response){
      console.log(response);
    })
  }

  webCtrl.destroy_hero = function(hero){
    var url = '/attachments/' + hero.id + '.json';
    $http.delete(url, hero).then(function(response){
      console.log(response);
      webCtrl.heros.splice(webCtrl.heros.indexOf(hero), 1);
    })
  }

  webCtrl.uploadFiles = function(files, errFiles, website_id) {
      $scope.files = files;
      $scope.errFiles = errFiles;
      angular.forEach(files, function(file) {
          file.upload = Upload.upload({
              url: '/hero_images.json',
              data: {asset: file, attachable_type: 'Website', attachable_id: website_id}
          });

          file.upload.then(function (response) {
              $timeout(function () {
                  file.result = response.data;
                  webCtrl.heros.push(file.result);
              });
          }, function (response) {
              if (response.status > 0)
                  $scope.errorMsg = response.status + ': ' + response.data;
          }, function (evt) {
              file.progress = Math.min(100, parseInt(100.0 *
                                       evt.loaded / evt.total));
          });
      });
  }

}

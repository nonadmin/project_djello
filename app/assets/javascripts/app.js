var djello = angular.module('djello', ['ui.router', 'restangular', 'Devise'])

.config(['RestangularProvider', function(RestangularProvider){
  RestangularProvider.setBaseUrl('/app/v1');
  RestangularProvider.setRequestSuffix('.json');
}]);
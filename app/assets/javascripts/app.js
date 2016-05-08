var djello = angular.module('djello', ['ui.router', 'restangular', 'Devise'])

.config(['RestangularProvider', function(RestangularProvider){
  RestangularProvider.setBaseUrl('/api/v1');
  RestangularProvider.setRequestSuffix('.json');
}])

.config(['$stateProvider', '$urlRouterProvider', 
  function($stateProvider, $urlRouterProvider){

  // No Board Index needed, API exposes index but this is only used for 
  // navigating between boards.
  $stateProvider
    .state('board', {
      url: '/boards/:id',
      templateUrl: 'templates/boards/show.html',
      controller: 'BoardShowCtrl',
      resolve: {
        board: ['BoardsAPI', '$stateParams', function( BoardsAPI, $stateParams){
          return BoardsAPI.show($stateParams.id);
        }],
        boards: ['BoardsAPI', function( BoardsAPI){
          return BoardsAPI.index();
        }],
      }
    });

  //$urlRouterProvider.otherwise('/index');  

}]);
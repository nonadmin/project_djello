var djello = angular.module('djello', ['ui.router', 'restangular', 'Devise'])

.config(['RestangularProvider', function(RestangularProvider){
  RestangularProvider.setBaseUrl('/api/v1');
  RestangularProvider.setRequestSuffix('.json');
}])

.config(['$stateProvider', '$urlRouterProvider', 
  function($stateProvider, $urlRouterProvider){

  // No Board Index needed, API exposes index but this is only used for 
  // navigating between boards.  We use a sort of redirect here to send 
  // user to last board created or make a new board if they have none
  $stateProvider
    .state('boards', {
      url: '/boards',
      controller: 'RedirectCtrl',
      resolve: {
        boards: ['BoardsAPI', function( BoardsAPI ){
          return BoardsAPI.index();
        }],
      }
    })

    .state('board', {
      url: '/boards/:id',
      templateUrl: 'templates/boards/show.html',
      controller: 'BoardShowCtrl',
      resolve: {
        board: ['BoardsAPI', '$stateParams', function( BoardsAPI, $stateParams ){
          console.log($stateParams);
          return BoardsAPI.show($stateParams.id);
        }],
        boards: ['BoardsAPI', function( BoardsAPI ){
          return BoardsAPI.index();
        }],
      }
    });

  $urlRouterProvider.otherwise('/boards');  

}])

.run(['$rootScope', function($rootScope){
  $rootScope.$on("$stateChangeError", console.log.bind(console));
}]);
var djello = angular.module('djello', ['ui.router', 'restangular', 'Devise'])

.config(['RestangularProvider', function(RestangularProvider){
  RestangularProvider.setBaseUrl('/api/v1');
  RestangularProvider.setRequestSuffix('.json');
}])

.config(['$stateProvider', '$urlRouterProvider', 
  function($stateProvider, $urlRouterProvider){

  $stateProvider

    .state('board', {
      url: '/boards/:id',
      templateUrl: 'templates/boards/show.html',
      controller: 'BoardShowCtrl',
      resolve: {
        boards: ['BoardsAPI', function( BoardsAPI ){
          return BoardsAPI.index();
        }],
        board: ['BoardsAPI', '$stateParams', 
          function( BoardsAPI, $stateParams ){
            return BoardsAPI.show($stateParams.id);
        }],
      }
    })

    .state('redirect', {
      url: '/redirect',
      controller: 'RedirectCtrl',
    });

  $urlRouterProvider.otherwise('/redirect');  

}])

.run(['$rootScope', function($rootScope){
  $rootScope.$on("$stateChangeError", console.log.bind(console));
}]);
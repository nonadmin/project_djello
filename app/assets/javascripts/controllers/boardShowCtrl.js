djello.controller('BoardShowCtrl', ['$scope', 'board',
  function($scope, board){

  $scope.board = board;
  $scope.inputTitle = board.title;

  $scope.update = function(){

  };

}]);
djello.controller('BoardShowCtrl', ['$scope', '$state', '$timeout', 'board', 'boards', 'BoardsAPI',
  function($scope, $state, $timeout, board, boards, BoardsAPI){

  $scope.board = board;
  $scope.boards = boards;
  $scope.inputTitle = board.title;
  $scope.showInput = false;

  $scope.hideInput = function(){
    if ($scope.boardForm.$valid) {    
      $scope.saved = false;
      $timeout(function () { // delay hiding incase ng-submit
          if ($scope.saved) return;
          $scope.inputTitle = board.title;
          $scope.showInput = false;
      }, 100);
    }
  };

  $scope.newBoard = function(){
    BoardsAPI.create()
      .then(function(board){
        $state.go('board', {id: board.id});
      });
  };

  $scope.updateBoard = function(){
    $scope.saved = true;

    if ($scope.boardForm.$valid) {
      $scope.board.title = $scope.inputTitle;

      BoardsAPI.update($scope.board)
        .then(function(board){
          $scope.showInput = false;
          $scope.board = board;
          $scope.inputTitle = board.title;

          // Update the boards object used by the boardSelect directive
          var idx = _.findIndex($scope.boards, ['id', board.id]);
          $scope.boards.splice(idx, 1, board);
          });
    }
  };

  $scope.deleteBoard = function(){
    BoardsAPI.remove($scope.board)
      .then(function(board){
        $state.go('boards');
      });
  };

}]);
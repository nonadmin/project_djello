djello.controller('BoardShowCtrl', ['$scope', '$state', '$timeout', 'board', 'boards', 'BoardsAPI', 'Restangular',
  function($scope, $state, $timeout, board, boards, BoardsAPI, Restangular){
 
  $scope.board = board;
  $scope.boards = boards;
  $scope.titleFieldOpts = {
    type: 'text',
    maxlength: 30,
  };

  $scope.resetForm = function(){
    $scope.formData.visible = false;
    $scope.formData.title = board.title;
  };

  $scope.newBoard = function(){
    BoardsAPI.create()
      .then(function(board){
        $state.go('board', {id: board.id});
      });
  };

  $scope.updateBoard = function(){
    BoardsAPI.update($scope.board)
      .then(function(board){
        $scope.board = board;

        // Update the boards object used by the boardSelect directive
        var idx = _.findIndex($scope.boards, ['id', board.id]);
        $scope.boards.splice(idx, 1, board);
        });
  };

  $scope.deleteBoard = function(){
    BoardsAPI.remove($scope.board)
      .then(function(board){
        $state.go('redirect');
      });
  };


}]);
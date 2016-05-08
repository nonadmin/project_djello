djello.controller('RedirectCtrl', ['$scope', '$state', 'boards', 'BoardsAPI',
  function($scope, $state, boards, BoardsAPI){

    if ( !boards.length ) {
      // User has no boards?  Create one and go to it
      BoardsAPI.create()
        .then(function(board){
          $state.go('board', {id: board.id});
        });
    } else {
      // Otherwise go to the last board created
      var last = _.last(boards);
      $state.go('board', {id: last.id});
    }

}]);
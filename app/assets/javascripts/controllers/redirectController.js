djello.controller('RedirectCtrl', ['$scope', '$state', 'BoardsAPI',
  function($scope, $state, BoardsAPI){

    BoardsAPI.index().then(function(boards){
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
    });


}]);
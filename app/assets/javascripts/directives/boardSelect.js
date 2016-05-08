djello.directive('boardSelect', ['$stateParams', '$state', 'BoardsAPI', 
  function($stateParams, $state, BoardsAPI){

  return {
    templateUrl: 'templates/boardSelect.html',
    restrict: 'E',
    scope: {},
    link: function(scope){
      // Load the list of boards from the API
      BoardsAPI.index()
        .then(function(boards){
          scope.boards = boards;
        });

      // Initialize the selected board based on params
      scope.selectedBoard = {id: $stateParams.id};

      scope.go = function(){
        $state.go('board', {id: scope.selectedBoard});
      };

    }
  };
}]);
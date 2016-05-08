djello.directive('boardSelect', ['$stateParams', '$state', 'BoardsAPI', 
  function($stateParams, $state, BoardsAPI){

  return {
    templateUrl: 'templates/boardSelect.html',
    restrict: 'E',
    scope: {
      boards: "="
    },
    link: function(scope){
      // Initialize the selected board based on params
      scope.selectedBoard = {id: $stateParams.id};

      scope.go = function(){
        $state.go('board', {id: scope.selectedBoard});
      };

    }
  };
}]);
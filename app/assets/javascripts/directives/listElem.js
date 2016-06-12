djello.directive('listElem',['ListsAPI', function(ListsAPI){
  return {
    templateUrl: 'templates/lists/show.html',
    restrict: 'E',
    scope: {
      list: "=",
    },
    link: function(scope){

      scope.titleFieldOpts = {
        type: 'text',
        minlength: 4,
        maxlength: 16,
      };

      scope.descriptionFieldOpts = {
        type: 'textarea',
        minlength: 10,
        maxlength: 512,
      };

      scope.updateList = function(){
        ListsAPI.update(scope.list)
          .then(function(list){
            scope.list = list;

            // Update the boards object used by the boardSelect directive
            // var idx = _.findIndex($scope.boards, ['id', board.id]);
            // $scope.boards.splice(idx, 1, board);
            });
      };


    }
  };
}]);
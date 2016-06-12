djello.factory('BoardsAPI', ['Restangular', function(Restangular){

  var index = function(){
    return Restangular.all('boards').getList();
  };

  var show = function(id){
    return Restangular.one('boards', id).get().then(function(board){
      Restangular.restangularizeCollection(
        board, board.lists, 'lists');
      
      return board;   
    });
  };

  var create = function(){
    return Restangular.all('boards').post();
  };

  var update = function(board){
    return board.put().then(function(board){
      Restangular.restangularizeCollection(
        board, board.lists, 'lists');

      return board;
    });
  };

  var remove = function(board){
    return board.remove();
  };

  return {
    index: index,
    show: show,
    create: create,
    update: update,
    remove: remove,
  };

}]);
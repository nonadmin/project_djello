djello.factory('BoardsAPI', ['Restangular', function(Restangular){

  var index = function(){
    return Restangular.all('boards').getList();
  };

  var show = function(id){
    return Restangular.one('boards', id).get();
  };

  var create = function(){
    return Restangular.all('boards').post();
  };

  var update = function(board){
    return board.put();
  };

  return {
    index: index,
    show: show,
    create: create,
    update: update,
  };

}]);
djello.factory('ListsAPI', ['Restangular', 'BoardsAPI',
  function(Restangular, BoardsAPI){

  var update = function(list){
    return list.put();
  };

  return {
    update: update,
  };

}]);
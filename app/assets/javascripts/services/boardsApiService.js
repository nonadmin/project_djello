djello.factory('BoardsAPI', ['Restangular', function(Restangular){

  var index = function(){
    return Restangular.all('boards').getList();
  };

  var show = function(id){
    return Restangular.one('boards', id).get();
  };

  return {
    index: index,
    show: show,
  };

}]);
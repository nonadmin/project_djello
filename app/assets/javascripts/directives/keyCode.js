djello.directive('keyCode', [function(){
  return {
    restrict: 'A',
    link: function(scope, element, attrs){
      element.bind('keydown', function(e){
        if ( (e.which || e.keyCode) == attrs.code ){
          
          scope.$apply(function(){
            scope.$eval(attrs.keyCode, {$event: e});
          });
        }
      });
    }
  };
}]);
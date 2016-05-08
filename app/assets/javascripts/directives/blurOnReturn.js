djello.directive('blurOnReturn', ['$timeout',
  function($timeout) {
    return {
    link : function(scope, element, attr) {
      element.bind("keydown, keypress", function(event) {
        if(event.which === 13) {
          element.blur();
          event.preventDefault();
          }
      });
    }
  };
}]); 
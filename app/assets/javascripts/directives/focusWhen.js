djello.directive('focusWhen', ['$timeout',
  function($timeout) {
    return {
    scope : {
      trigger : '@focusWhen'
    },
    link : function(scope, element, attr) {
      scope.$watch('trigger', function(value) {
        if (value === "true") {
          $timeout(function() {
           element.focus();
          });
        }
      });
    }
  };
}]); 
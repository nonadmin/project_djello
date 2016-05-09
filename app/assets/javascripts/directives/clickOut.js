djello.directive('clickOut', ['$window', '$parse', 
  function ($window, $parse) {
    return {
      restrict: 'A',
      link: function (scope, element, attrs) {
        // grab the function passed to the directive
        var clickOutHandler = $parse(attrs.clickOut);

        angular.element($window).on('click', function (event) {          
          // if input is shown and click is outside div
          if (!element[0].contains(event.target) && scope.formData.visible){
            // run function passed to clickOut.
            clickOutHandler(scope, {$event: event});
            scope.$apply();
          } 
            
        });
      }
    };
  }]);
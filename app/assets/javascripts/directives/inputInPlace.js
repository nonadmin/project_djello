djello.directive('inputInPlace', ['$timeout', function($timeout){
  return {
    templateUrl: 'templates/inputInPlace.html',
    transclude: true,
    restrict: 'E',
    scope: {
      model: "=",
      field: "=",
      saveFn: "&"
    },
    link: function(scope, element, attrs){
      scope.formData = {
        inputModel: scope.model,
        visible: false,
      };

      scope.resetForm = function(){
        scope.formData.visible = false;
        scope.formData.inputModel = scope.model;
      };

      scope.submit = function(){
        if (scope.changeForm.$valid) {
          scope.model = scope.formData.inputModel;
          scope.formData.visible = false;
          $timeout(function(){
            // $timeout used to call parent saveFn during next digest cycle
            // once our var has been updated
            scope.saveFn();
          });
        }
      };

      // Only needed if model changes after save, such as blank board title
      // replaced with "Untitled"
      scope.$watch('model', function(v){
        scope.formData.inputModel = v;
      });
    },
  };
}]);
function surak() {
	return {
		restrict: 'E',
		controller: ['$scope',
		function($scope){
			var ctrl =  this;

  	}],
		controllerAs: 'surakCtrl',
		templateUrl: 'surak/default.tpl.html',
	};
}

angular
	.module('app')
	.directive('surak', surak);

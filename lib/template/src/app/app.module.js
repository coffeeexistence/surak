angular
  .module( 'app', [ 'ngMaterial', 'ui.router', 'ngSanitize', 'angular-bind-html-compile'] )
    .config(['$stateProvider', '$urlMatcherFactoryProvider', function($stateProvider, $urlMatcherFactoryProvider){

      $urlMatcherFactoryProvider.strictMode(false);
      $stateProvider

        .state('main', {
          url: '',
          templateUrl: 'templates/main.tpl.html',
          controller: 'MainController',
          controllerAs: 'ctrl'
        });

    }]);

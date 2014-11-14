window.App = angular.module('Breakfasts', ['templates', 'ngRoute']);

App.config(function($httpProvider, $routeProvider) {
  $routeProvider.when('/', {
    templateUrl: 'angular_application/templates/index.html',
    controller: 'HomeCtrl'
  }).otherwise({
    redirectTo: '/'
  });
});


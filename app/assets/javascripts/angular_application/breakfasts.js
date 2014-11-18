window.App = angular.module('Breakfasts', ['templates', 'ngResource', 'ngRoute']);

App.config(function($httpProvider, $routeProvider) {
  $routeProvider.when('/', {
    templateUrl: 'angular_application/templates/home.html',
    controller: 'HomeCtrl'
  }).otherwise({
    redirectTo: '/'
  });
});


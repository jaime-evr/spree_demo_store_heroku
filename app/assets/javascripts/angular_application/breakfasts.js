window.App = angular.module('Breakfasts', ['templates', 'ngResource', 'ngRoute']);

App.config(function($httpProvider, $routeProvider) {
  $httpProvider.interceptors.push('authInterceptor');

  $routeProvider.when('/login', {
    templateUrl: 'angular_application/templates/sign_in.html',
    controller: 'AuthenticationsCtrl',
  }).when('/home', {
    templateUrl: 'angular_application/templates/home.html',
    controller: 'HomeCtrl'
  }).otherwise({
    redirectTo: '/login'
  });
});


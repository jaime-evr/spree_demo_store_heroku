window.App = angular.module('Breakfasts', ['templates', 'ngResource', 'ngRoute']);

App.config(['$httpProvider', '$routeProvider',
  function($httpProvider, $routeProvider) {
    $httpProvider.interceptors.push('authInterceptor');

    $routeProvider.when('/login', {
      templateUrl: 'angular_application/templates/sign_in.html',
      controller: 'AuthenticationsCtrl',
    }).when('/home', {
      templateUrl: 'angular_application/templates/home.html',
      controller: 'HomeCtrl'
    }).when('/orders', {
      templateUrl: 'angular_application/templates/orders.html',
      controller: 'OrdersCtrl'
    }).when('/cart', {
      templateUrl: 'angular_application/templates/cart.html',
      controller: 'CartCtrl'
    }).otherwise({
      redirectTo: '/login'
    });
  }
]);


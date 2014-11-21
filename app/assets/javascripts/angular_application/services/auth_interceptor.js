App.factory('authInterceptor', ['$rootScope', '$window', '$location',
  function($rootScope, $window, $location) {
    return {
      request: function(config) {
        if($window.sessionStorage.token) {
          config.headers['X-Spree-Token'] = $window.sessionStorage.token;
        }
        return config;
      },
      responseError: function(response) {
        if(response.status == 401) {
          $location.path('/');
        }
        return response;
      }
    }
  }
]);


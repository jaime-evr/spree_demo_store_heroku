App.factory('authInterceptor', ['$rootScope', '$window', '$location',
  function($rootScope, $window, $location) {
    return {
      request: function(config) {
        if($window.sessionStorage.getItem('user')) {
          user = JSON.parse($window.sessionStorage.getItem('user'));
          config.headers['X-Spree-Token'] = user.spree_api_key
        } else {
          $location.path('login');
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


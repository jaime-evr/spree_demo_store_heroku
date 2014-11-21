App.controller('AuthenticationsCtrl', ['$scope', '$routeParams', '$location', '$window', 'CreateUser', 'AuthenticateUser',
  function($scope, $routeParams, $location, $window, CreateUser, AuthenticateUser) {
    $scope.signedIn = false;

    $scope.processAuth = function(authResult) {
      if(authResult['access_token']) {
        $scope.signedIn = true;

        $scope.getUserInfo();
      } else if(authResult['error']) {
        $scope.signedIn = false;
      }
    };

    $scope.signInCallback = function(authResult) {
      $scope.$apply(function() {
        $scope.processAuth(authResult);
      });
    };

    $scope.renderSignInButton = function() {
      gapi.signin.render('signInButton',
        {
         'callback': $scope.signInCallback,
         'clientid': '667263210901-g4gv6vkuhsbmm5srqe0jji8va549bbd9.apps.googleusercontent.com',
         'requestvisibleactions': 'http://schemas.google.com/AddActivity',
         'scope': 'https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email',
         'cookiepolicy': 'single_host_origin'
        }
      );
    }

    $scope.login = function() {
      $scope.renderSignInButton();
    };

    $scope.processUserInfo = function(userInfo) {
      userParams = {
        email: userInfo.emails[0].value,
        password: userInfo.id
      }

      user = new AuthenticateUser({
        spree_user: userParams
      });

      user.$save(function(response) {
        if(response.error) {
          $scope.registerUser(userParams);
        } else {
          $window.sessionStorage.setItem('user', JSON.stringify(response.user));
          $location.path('/home');
        }
      }, function(error) {
        $scope.registerUser(userParams);
      });
    };

    $scope.registerUser = function(userParams) {
      user = new CreateUser({
        user: userParams
      });

      user.$save(function(response) {
        $window.sessionStorage.setItem('user', JSON.stringify(response));
        $location.path('/home');
      }, function(error) {
        delete $window.sessionStorage.token
        $location.path('login');
      });
    };

    $scope.userInfoCallback = function(userInfo) {
      $scope.$apply(function() {
        $scope.processUserInfo(userInfo);
      });
    };

    $scope.getUserInfo = function() {
      gapi.client.request(
        {
          'path':'/plus/v1/people/me',
          'method':'GET',
          'callback': $scope.userInfoCallback
        }
      );
    };
  }
]);


App.controller('AuthenticationsCtrl', ['$scope', '$routeParams', '$location', '$window', 'CreateUser', 'AuthenticateUser',
  function($scope, $routeParams, $location, $window, CreateUser, AuthenticateUser) {
    $scope.signedIn = false;

    $scope.processAuthResponse = function(authResult) {
      $scope.$apply(function() {
        if(authResult['access_token']) {
          $scope.signedIn = true;
          $scope.getUserInfo();
        } else if(authResult['error']) {
          $scope.signedIn = false;
        }
      });
    };

    $scope.signIn = function() {
      gapi.auth.signIn({
        'callback': $scope.processAuthResponse,
        'clientid': '667263210901-g4gv6vkuhsbmm5srqe0jji8va549bbd9.apps.googleusercontent.com',
        'requestvisibleactions': 'http://schemas.google.com/AddActivity',
        'scope': 'https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email',
        'cookiepolicy': 'single_host_origin'
      });
    };

    $scope.processUserInfo = function(userInfo) {

      $scope.$apply(function() {
        userParams = {
          email: userInfo.emails[0].value,
          password: userInfo.etag,
          image_url: userInfo.image.url
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
      });
    };

    $scope.registerUser = function(userParams) {
      var address = {
        first_name: 'Admin',
        last_name: 'User',
        address1: 'main st',
        address2: 'second st',
        country_id: 49,
        state_id: 32,
        city: 'Bethesda',
        zipcode: '20814',
        phone: '(555) 555-5555'
      }

      var user = {
        email: userParams.email,
        password: userParams.password,
        image_url: userParams.image_url,
        ship_address_attributes: address,
        bill_address_attributes: address
      }

      user = new CreateUser({
        user: user
      });

      user.$save(function(response) {
        if(response.error) {
          console.log(response.errors);
        } else {
          $window.sessionStorage.setItem('user', JSON.stringify(response));
          $location.path('/home');
        }
      }, function(error) {
        delete $window.sessionStorage.token
        $location.path('login');
      });
    };

    $scope.getUserInfo = function() {
      gapi.client.request(
        {
          'path':'/plus/v1/people/me',
          'method':'GET',
          'callback': $scope.processUserInfo
        }
      );
    };
  }
]);


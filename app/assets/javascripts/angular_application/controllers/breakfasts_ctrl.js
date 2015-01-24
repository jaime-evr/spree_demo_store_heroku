App.controller('BreakfastsCtrl', ['$scope', '$window', '$location',
  function($scope, $window, $location) {
    $scope.signedIn = false;

    $scope.logOut = function() {
      gapi.auth.signOut();
      delete $window.sessionStorage.removeItem('user')
      $location.path('/login');
    };
  }
]);


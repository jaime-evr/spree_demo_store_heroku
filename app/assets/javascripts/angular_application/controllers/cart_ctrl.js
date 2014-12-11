App.controller('CartCtrl', ['$scope', '$location', '$window', 'Checkout', 'Cart',
  function($scope, $location, $window, Checkout, Cart) {
    $scope.lineItems = Cart.lineItems;

    $scope.placeOrder = function() {
      var user = JSON.parse($window.sessionStorage.getItem('user'));
      var items = [];

      for(var key in $scope.lineItems) {
        items.push($scope.lineItems[key]);
      }

      var checkout = new Checkout({
        user_id: user.id,
        order: {
          line_items: items
        }
      });

      checkout.$save(function(order) {
        if(order.errors) {
          console.log(order.errors);
        } else {
          for (key in $scope.lineItems) delete $scope.lineItems[key];
          $location.path('/orders');
        }
      });
    };
  }
]);


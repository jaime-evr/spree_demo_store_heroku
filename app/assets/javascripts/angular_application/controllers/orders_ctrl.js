App.controller('OrdersCtrl', ['$scope', 'Order',
  function($scope, Order) {
    Order.query(function(data) {
      $scope.orders = data.orders;
    });
  }
]);


App.controller('HomeCtrl', ['$scope', '$routeParams', 'Product',
  function($scope, $routeParams, Product) {
    Product.query(function(data) {
      $scope.products = data.products;
    });

    $scope.product = Product.get({id: $routeParams.id});

  }
]);


App.controller('HomeCtrl', ['$scope', 'Checkout', 'Product',
  function($scope, Checkout, Product) {
    Product.query(function(data) {
      $scope.categories = data.categories;
      $scope.products = data[todayDate()];
    });

    $scope.renderCategoryProducts = function(categoryId) {
      var categoryProducts = [];

      $scope.products.forEach(function(product) {
        if(product.taxon_ids.indexOf(categoryId) > -1) {
          categoryProducts.push(product);
        }
      });

      return categoryProducts;
    };

    $scope.addToCart = function() {
      if(typeof $scope.order === 'undefined') {
        checkout = new Checkout();
        checkout.$save(function(order) {
          $scope.order = order;
        });
      }
    };

    var todayDate = function() {
      var date  = new Date();
      var day   = date.getDate();
      var month = date.getMonth() + 1;
      var year  = date.getFullYear();
      return year + "-" + month + "-" + day;
    }
  }
]);


App.controller('HomeCtrl', ['$scope', '$window', '$location', 'Product', 'Cart',
  function($scope, $window, $location, Product, Cart) {
    $scope.lineItems = Cart.lineItems;

    $scope.countInCart = function() {
      return Object.keys($scope.lineItems).length;
    };

    Product.query(function(data) {
      $scope.categories = data.categories;
      $scope.products = data[todayDate()];
    });

    $scope.renderCategoryProducts = function(category) {
      var categoryProducts = [];
      var now = new Date().getHours();

      if (category.name == "Cafe" || category.name == "Desayuno") {
        if (now < 7 || now > 9) {
          return category.isHidden = true;
        }
      }

      $scope.products.forEach(function(product) {
        if(product.taxon_ids.indexOf(category.id) > -1) {
          categoryProducts.push(product);
          if ($scope.lineItems[product.id]) product.inCart = true
        }
      });

      return categoryProducts;
    };

    $scope.goToCart = function() {
      $location.path('/cart');
    }

    $scope.addToCart = function(product) {
      $scope.lineItems[product.id] = {
        variant_id: product.master.id,
        quantity: 1,
        comment: 'test test test test test test test test',
        delivery_time: "10",
        name: product.name
      }
      product.inCart = true;
    };

    $scope.addQuantity = function(id) {
      if ($scope.lineItems[id].quantity == 1) {
        if (confirm("Are you sure you want to add two items to your order?")) {
          $scope.lineItems[id].quantity++;
        }
      } else {
        $scope.lineItems[id].quantity++;
      }
    };

    $scope.removeQuantity = function(product) {
      if ($scope.lineItems[product.id].quantity == 1) {
        delete $scope.lineItems[product.id];
        product.inCart = false;
      } else {
        $scope.lineItems[product.id].quantity--;
      }
    };

    $scope.logOut = function() {
      gapi.auth.signOut();
      delete $window.sessionStorage.removeItem('user')
      $location.path('/login');
    };

    var todayDate = function() {
      var date  = new Date();
      var day   = ("0" + date.getDate()).slice(-2);
      var month = ("0" + (date.getMonth() + 1)).slice(-2);
      var year  = date.getFullYear();
      return year + "-" + month + "-" + day;
    }
  }
]);


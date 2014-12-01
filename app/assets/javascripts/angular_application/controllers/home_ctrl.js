App.controller('HomeCtrl', ['$scope', '$window', '$location', 'Checkout', 'Product',
  function($scope, $window, $location, Checkout, Product) {
    $scope.lineItems = {};

    Product.query(function(data) {
      $scope.categories = data.categories;
      $scope.products = data[todayDate()];
    });

    $scope.renderCategoryProducts = function(category) {
      var categoryProducts = [];
      var now = new Date().getHours();

      if (now <= 7 && now >= 10) {
        if (category.name == "Cafe" || category.name == "Desayuno") {
          return category.isHidden = true;
        }
      }

      $scope.products.forEach(function(product) {
        if(product.taxon_ids.indexOf(category.id) > -1) {
          categoryProducts.push(product);
        }
      });

      return categoryProducts;
    };

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
          $location.path('/orders');
        }
      });
    }

    $scope.addToCart = function(product) {
      $scope.lineItems[product.id] = {
        variant_id: product.master.id,
        quantity: 1,
        delivery_time: "10",
      }
      product.inCart = true;
    };

    $scope.addQuantity = function(id) {
      if (confirm("Are you sure?")) {
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
      var day   = date.getDate();
      var month = date.getMonth() + 1;
      var year  = date.getFullYear();
      return year + "-" + month + "-" + day;
    }
  }
]);


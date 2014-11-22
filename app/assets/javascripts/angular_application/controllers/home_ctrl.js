App.controller('HomeCtrl', ['$scope', '$window', '$location', 'Checkout', 'Product',
  function($scope, $window, $location, Checkout, Product) {
    $scope.lineItems = [];

    Product.query(function(data) {
      $scope.categories = data.categories;
      $scope.products = data[todayDate()];
    });

    $scope.renderCategoryProducts = function(category) {
      var categoryProducts = [];
      var now = new Date().getHours();
      if (now >= 7 && now <= 12) {
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

      var checkout = new Checkout({
        user_id: user.id,
        order: {
          line_items: $scope.lineItems
        }
      });

      checkout.$save(function(order) {
        $scope.order = order;
      });
    }

    $scope.addToCart = function(product) {
      item = {
        variant_id: product.master.id,
        quantity: 1
      }
      product.inCart = true;
      $scope.lineItems.push(item);
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


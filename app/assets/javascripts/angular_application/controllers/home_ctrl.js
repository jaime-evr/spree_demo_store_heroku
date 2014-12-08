App.controller('HomeCtrl', ['$scope', '$window', '$location', 'Checkout', 'Product',
  function($scope, $window, $location, Checkout, Product) {
    $scope.lineItems = {};

    $scope.createLocation = function() {
      debugger;
      console.log("home controller");
    };

    $scope.testSubmit = function() {
      debugger;
      console.log("testSubmit");
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
        }
      });

      return categoryProducts;
    };

    $scope.makeOrder = function() {
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
      debugger;
      $scope.lineItems[product.id] = {
        variant_id: product.master.id,
        quantity: 1,
        delivery_time: "10",
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
      var month = date.getMonth() + 1;
      var year  = date.getFullYear();
      return year + "-" + month + "-" + day;
    }
  }
]);


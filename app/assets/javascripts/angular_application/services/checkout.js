App.factory('Checkout', ['$resource',
  function($resource) {
    return $resource('/api/checkouts', {}, {
      query: { params: { isArray: true } }
    });
  }
]);


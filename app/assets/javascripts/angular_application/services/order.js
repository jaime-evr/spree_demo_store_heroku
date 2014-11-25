App.factory('Order', ['$resource',
  function($resource) {
    return $resource('api/orders/mine', {}, {
      query: { params: { isArray: true } }
    });
  }
]);


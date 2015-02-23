App.factory('Product', ['$resource',
  function($resource) {
    return $resource('/api/products/:id', {}, {
      query: { params: { isArray: true }, cache: true },
    });
  }
]);


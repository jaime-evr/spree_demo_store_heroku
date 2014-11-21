App.factory('CreateUser', ['$resource',
  function($resource) {
    return $resource('/api/users', {});
  }
]);


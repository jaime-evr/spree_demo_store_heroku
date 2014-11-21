App.factory('AuthenticateUser', ['$resource',
  function($resource) {
    return $resource('/api/v1/authorizations', {});
  }
]);



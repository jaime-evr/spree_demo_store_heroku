App.directive('mainMenu', function() {
  return {
    restrict: 'E',
    replace: true,
    scope: {},
    templateUrl: 'angular_application/templates/main_menu.html',
    link: function(scope, element, attrs) {
      //element.find('li').on('click', function() {
        //$('html').removeClass('is-menu-visible');
      //});
    }
  }
});


App.directive('menuButton', function() {
  return {
    restrict: 'E',
    replace: true,
    scope: {},
    templateUrl: 'angular_application/templates/menu_button.html',
    link: function(scope, element, attrs) {
      var isNavOpen = false;
      var doc = $('html');

      element.on('click', function() {
        if(isNavOpen && doc.hasClass('is-menu-visible')) {
          doc.removeClass('is-menu-visible');
          isNavOpen = false;
        } else {
          doc.addClass('is-menu-visible');
          isNavOpen = true;
        }
      });

      doc.on('click', function(e) {
        if(isNavOpen && $(e.target).parents('#main').length) {
          doc.removeClass('is-menu-visible');
          isNavOpen = false;
        }
      });
    }
  }
});


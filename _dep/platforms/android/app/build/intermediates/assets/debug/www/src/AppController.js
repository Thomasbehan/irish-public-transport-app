/**
 * Main App Controller for the AngularJS Material Starter App
 * @param UsersDataService
 * @param $mdSidenav
 * @constructor
 */
function AppController(UsersDataService, $mdSidenav, $scope) {
  var self = this;

  self.selected     = null;
  self.users        = [ ];
  self.selectUser   = selectUser;
  self.toggleList   = toggleUsersList;

  // Load all registered users

  UsersDataService
        .loadAllUsers()
        .then( function( users ) {
          self.users    = [].concat(users);
          self.selected = users[0];
        });

  // *********************************
  // Internal methods
  // *********************************

  /**
   * Hide or Show the 'left' sideNav area
   */
  function toggleUsersList() {
    $mdSidenav('left').toggle();
  }
    $scope.sidenavItems = [
        {"name": "Home", "icon": "home_outlined", "desc": "The main page including search and favourites", "link": "#/"},
        {"name": "Stops", "icon": "stops_outlined", "desc": "This is for seatching by stop or terminal ID ", "link": "#/stops"},
        {"name": "Routes", "icon": "directions_outlined", "desc": "This is for seatching by routes ", "link": "#/routes"},
        {"name": "Settings", "icon": "settings_outlined", "desc": "A settings/about page", "link": "#/settings"}
    ];
  /**
   * Select the current avatars
   * @param menuId
   */
  function selectUser ( user ) {
    self.selected = angular.isNumber(user) ? $scope.users[user] : user;
  }
}

export default [ 'UsersDataService', '$mdSidenav', '$scope', AppController ];

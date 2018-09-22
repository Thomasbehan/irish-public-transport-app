export default function settingsController($scope, $http, $location, $mdDialog, $mdToast, $localStorage) {
    $scope.saveSettings = function(){
        $mdToast.show($mdToast.simple().textContent('Nothing to save right now').hideDelay(3000));
    }
}

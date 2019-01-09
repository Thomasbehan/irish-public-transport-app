export default function homeController($scope, $http, $location, $mdDialog, $localStorage, $rootScope, stopsService) {
    $scope.favourites = [];
    if ($localStorage.favourite != undefined){
        $scope.favourites = $localStorage.favourite;
    }else{
        $localStorage.favourite = [];
    }
    $scope.searchStop = function (search) {
        stopsService.searchStop(search);
    }
    $scope.showSearch = function (ev) {
        $mdDialog.show({
            controller: function ($scope, $location, $mdDialog) {
                $scope.searchStop = function (search) {
                    $location.path('/results/' + search);
                    $mdDialog.hide();
                }
            },
            templateUrl: 'src/templates/modals/search.html',
            parent: angular.element(document.body),
            targetEvent: ev,
            clickOutsideToClose: true,
            fullscreen: false
        })
        .then(function (result) {
            
        }, function () {
            
        });
    };
    
}
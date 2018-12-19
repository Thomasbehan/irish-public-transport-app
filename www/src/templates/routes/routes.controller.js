export default function routesController($scope, $routeParams, $http, $location, $interval, $rootScope, $localStorage) {
    $rootScope.loading = true;
    $scope.url = "https://data.smartdublin.ie/cgi-bin/rtpi/routelistinformation?format=json";
    $scope.getRoute = function () {
        $rootScope.loading = true;
        $http.get($scope.url).then(function (response) {
            $rootScope.loading = false;
            $scope.stop = response.data;
            if ($localStorage.favourite != undefined) {
                if ($localStorage.favourite.indexOf($scope.stop.stopid) > -1) {
                    $scope.isFavourite = true;
                }
            } else {
                $localStorage.favourite = [];
            }
            $scope.routes = response.data.results;

        });
    };

    $scope.getRoute();
};

export default function stopsController($scope, $routeParams, $http, $location, $interval, $rootScope, $localStorage, stopsService) {
    $rootScope.loading = true;
    $scope.url = "https://data.smartdublin.ie/cgi-bin/rtpi/busstopinformation?stopid&format=json";
    $scope.operatorUrl = "https://data.smartdublin.ie/cgi-bin/rtpi/operatorinformation?format=json";
    $scope.operators = null;
    $scope.searchStop = function(stop_id) {
        stopsService.searchStop(stop_id);
    }
    $scope.getStops = function () {
        $rootScope.loading = true;
        $http.get($scope.url).then(function (response) {
            $rootScope.loading = false;
            $scope.stops = response.data.results;
            angular.forEach($scope.stops, function(obj){
                angular.forEach(obj.operators, function(opObj){
                   opObj.fullname = $scope.operators[$scope.operators.findIndex( operator => operator.operatorreference === opObj.name )].operatorname;
                });
            });
        });
    };
    $scope.getOperatorInformation = function () {
        $rootScope.loading = true;
        $http.get($scope.operatorUrl).then(function (response) {
            $rootScope.loading = false;
            $scope.operators = response.data.results;
            $scope.getStops();
        });
    };
    $scope.getOperatorInformation();
};

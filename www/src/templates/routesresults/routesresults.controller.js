export default function routesresultsController($scope, $routeParams, $http, $location, $interval, $localStorage, $mdToast, $rootScope, $filter) {
    $scope.stops = [];
    $scope.stop = [];
    $scope.isFavourite = false;
    $scope.stop.routeid = $routeParams.routeid;
    $scope.toggleFavourite = function () {
        if ($localStorage.favourite == undefined) {
            $localStorage.favourite = [];
        }
        if ($scope.isFavourite == false) {
            $localStorage.favourite.push($scope.stop.stopid);
        } else {
            var index = $localStorage.favourite.indexOf($scope.stop.stopid);
            if (index > -1) {
                $localStorage.favourite.splice(index, 1);
            }
        }
        $scope.isFavourite = !$scope.isFavourite;
    }
    $scope.url = "https://data.smartdublin.ie/cgi-bin/rtpi/routeinformation?routeid=" + $routeParams.routeid + 
        "&operator=" + $routeParams.operator +"&format=json";
    $scope.checkStop = function () {
        $rootScope.loading = true;
        $http.get($scope.url).then(function (response) {
            $rootScope.loading = false;
            if (response.data.errorcode === "0") {
                $scope.stop = response.data;
                if ($localStorage.favourite != undefined) {
                    if ($localStorage.favourite.indexOf($scope.stop.stopid) > -1) {
                        $scope.isFavourite = true;
                    }
                } else {
                    $localStorage.favourite = [];
                }
                $scope.stops = response.data.results;
                angular.forEach($scope.stops, function (d) {
                    var currentTime = moment($scope.stop.timestamp, 'DD/MM/YYYY hh:mm:ss').unix() * 1000;
                    $scope.stop.formattedTime = $filter('date')(currentTime, 'dd MMM - HH:mm:ss');
                    var newDate = moment(d.arrivaldatetime, 'DD/MM/YYYY hh:mm:ss').unix() * 1000;
                    var difference = newDate - currentTime;
                    var daysDifference = Math.floor(difference / 1000 / 60 / 60 / 24);
                    difference -= daysDifference * 1000 * 60 * 60 * 24;
                    var hoursDifference = Math.floor(difference / 1000 / 60 / 60);
                    difference -= hoursDifference * 1000 * 60 * 60;
                    var minutesDifference = Math.floor(difference / 1000 / 60);
                    difference -= minutesDifference * 1000 * 60;
                    var secondsDifference = Math.floor(difference / 1000);
                    var daysDifferenceText = "";
                    var hoursDifferenceText = "";
                    var minutesDifferenceText = "";
                    var secondsDifferenceText = "";
                    if (daysDifference > 0) {
                        daysDifferenceText = daysDifference + ' day/s ';
                    }
                    if (hoursDifference > 0) {
                        hoursDifferenceText = hoursDifference + ' hour ';
                    }
                    if (hoursDifference > 1) {
                        hoursDifferenceText = hoursDifference + ' hours ';
                    }
                    if (minutesDifference > 0) {
                        minutesDifferenceText = minutesDifference + ' min ';
                    }
                    if (minutesDifference > 1) {
                        minutesDifferenceText = minutesDifference + ' mins ';
                    }
                    if (minutesDifference == 0 && secondsDifference > 0) {
                        secondsDifferenceText = secondsDifference + ' seconds ';
                    }
                    d.estArrival = daysDifferenceText + hoursDifferenceText + minutesDifferenceText + secondsDifferenceText;

                });
            } else {
                $location.path('/');
                $mdToast.show($mdToast.simple().textContent('Stop not found!').position('bottom center'));
            }
        });
        $scope.checkTime = 10;
    };
    $scope.checkStop();
    $scope.checkTime = 10;
   
    $scope.countSecond = $interval(function () {
        $scope.checkTime = $scope.checkTime - 1;
    }, 1000);
    $scope.$on('$destroy', function () {
        $interval.cancel($scope.countSecond);
    });
}

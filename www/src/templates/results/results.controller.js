export default function homeController($scope, $routeParams, $http, $location, $interval) {
	$scope.stops = [];
	$scope.stop = [];
	$scope.stop.stopid = $routeParams.stopid;
	$scope.url = "https://data.smartdublin.ie/cgi-bin/rtpi/realtimebusinformation?stopid=" + $routeParams.stopid + "&format=json";
	$scope.checkStop = function(){
		$http.get($scope.url).then(function (response) {
			$scope.stop = response.data;
			console.log(response.data);
			$scope.stops = response.data.results;
			angular.forEach($scope.stops, function (d) {
				var currentTime = moment($scope.stop.timestamp, 'DD/MM/YYYY hh:mm:ss').unix() * 1000;
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
				if(daysDifference > 0){
					daysDifferenceText = daysDifference + ' day/s ';
				}
				if(hoursDifference > 0){
					hoursDifferenceText = hoursDifference + ' hour ';
				}
				if(hoursDifference > 1){
					hoursDifferenceText = hoursDifference + ' hours ';
				}
				if(minutesDifference > 0){
					minutesDifferenceText = minutesDifference + ' min ';
				}
				if(minutesDifference > 1){
					minutesDifferenceText = minutesDifference + ' mins ';
				}
				if(minutesDifference == 0 && secondsDifference > 0){
					secondsDifferenceText = secondsDifference + ' seconds ';
				}
				d.estArrival = daysDifferenceText + hoursDifferenceText + minutesDifferenceText + secondsDifferenceText;

			});
		});
	};
	$scope.checkStop();
	$scope.autoUpdate = $interval(function() {
		$scope.checkStop();
	}, 10000);
	$scope.$on('$destroy',function(){
		$interval.cancel($scope.autoUpdate);
	});
}

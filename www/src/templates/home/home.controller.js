export default function homeController($scope, $http) {
 	$scope.stops = [];
	$scope.url = "https://data.smartdublin.ie/cgi-bin/rtpi/busstopinformation?stopid&format=json";
	$http.get($scope.url).then(function(response) {
			$scope.stops = response.data.results;
	});
}
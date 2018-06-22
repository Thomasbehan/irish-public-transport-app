export default function homeController($scope, $http, $location) {
 	$scope.stops = [];
//	$scope.url = "http://www.dublinbus.ie/api/events?format=json";
//	$http.get($scope.url).then(function(response) {
//			$scope.stops = response.data.events;
//	});
	$scope.searchStop = function(search){
		$location.path('/results/' + search.stop);
	}
}
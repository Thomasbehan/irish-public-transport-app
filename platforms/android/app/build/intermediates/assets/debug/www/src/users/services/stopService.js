export default function stopService($q, $location, $mdDialog) {
    this.searchStop = function(stop_id){
        $location.path('/results/' + stop_id);
        $mdDialog.hide();
    }
};
export default function settingsController($scope, $http, $location, $mdDialog, $mdToast, $localStorage) {
//    cordova.plugins.firebase.analytics.setCurrentScreen("Settings Page");
    $scope.saveSettings = function(){
        $mdToast.show($mdToast.simple().textContent('Nothing to save right now').hideDelay(3000));
    }
    $scope.share = function(){
        var options = {
          message: 'Check out the Irish Transport App, its fast and has tons of features.', // not supported on some apps (Facebook, Instagram)
          subject: 'The Irish Public Transport App', // fi. for email
//          files: ['', ''], // an array of filenames either locally or remotely
          url: 'https://play.google.com/store/apps/details?id=ie.natosoft.ipt',
          chooserTitle: 'Pick an app' // Android only, you can override the default share sheet title
        };

        var onSuccess = function(result) {
          console.log("Share completed? " + result.completed); // On Android apps mostly return false even while it's true
          console.log("Shared to app: " + result.app); // On Android result.app since plugin version 5.4.0 this is no longer empty. On iOS it's empty when sharing is cancelled (result.completed=false)
        };

        var onError = function(msg) {
          console.log("Sharing failed with message: " + msg);
        };

        window.plugins.socialsharing.shareWithOptions(options, onSuccess, onError);
    }
}

cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
  {
    "id": "es6-promise-plugin.Promise",
    "file": "plugins/es6-promise-plugin/www/promise.js",
    "pluginId": "es6-promise-plugin",
    "runs": true
  },
  {
    "id": "cordova-plugin-x-socialsharing.SocialSharing",
    "file": "plugins/cordova-plugin-x-socialsharing/www/SocialSharing.js",
    "pluginId": "cordova-plugin-x-socialsharing",
    "clobbers": [
      "window.plugins.socialsharing"
    ]
  },
  {
    "id": "cordova-plugin-firebase-analytics.FirebaseAnalytics",
    "file": "plugins/cordova-plugin-firebase-analytics/www/FirebaseAnalytics.js",
    "pluginId": "cordova-plugin-firebase-analytics",
    "merges": [
      "cordova.plugins.firebase.analytics"
    ]
  }
];
module.exports.metadata = 
// TOP OF METADATA
{
  "cordova-plugin-whitelist": "1.3.3",
  "es6-promise-plugin": "4.2.2",
  "cordova-plugin-x-socialsharing": "5.4.3",
  "cordova-support-android-plugin": "1.0.1",
  "cordova-support-google-services": "1.2.1",
  "cordova-plugin-firebase-analytics": "1.0.1"
};
// BOTTOM OF METADATA
});
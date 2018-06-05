// Load libraries
import angular from 'angular';

import 'angular-animate';
import 'angular-aria';
import 'angular-material';
import 'angular-route';

import AppController from 'src/AppController';
import homeController from 'src/templates/home/home.controller';
import Users from 'src/users/Users';

export default angular.module('starter-app', ['ngMaterial', 'ngRoute', Users.name])
	.config(($mdIconProvider, $mdThemingProvider) => {
		// Register the user `avatar` icons
		$mdIconProvider
			.defaultIconSet("./assets/svg/avatars.svg", 128)
			.icon("menu", "./assets/svg/menu.svg", 24)
			.icon("share", "./assets/svg/share.svg", 24)
			.icon("google_plus", "./assets/svg/google_plus.svg", 24)
			.icon("hangouts", "./assets/svg/hangouts.svg", 24)
			.icon("twitter", "./assets/svg/twitter.svg", 24)
			.icon("phone", "./assets/svg/phone.svg", 24);

		$mdThemingProvider.theme('default')
			.primaryPalette('blue')
			.accentPalette('red');
	}).config(function ($routeProvider) {
		$routeProvider
			.when("/", {
				title: "home",
				templateUrl: "src/templates/home/home.html",
				controller: "homeController"
			}).when("/page2", {
				title: "Page2",
				templateUrl: "src/templates/page2/page2.html"
			});
	})
	.controller('AppController', AppController)
	.controller('homeController', homeController);

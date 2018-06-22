// Load libraries
import angular from 'angular';

import 'angular-animate';
import 'angular-aria';
import 'angular-material';
import 'angular-route';

import AppController from 'src/AppController';
import homeController from 'src/templates/home/home.controller';
import resultsController from 'src/templates/results/results.controller';
import Users from 'src/users/Users';

export default angular.module('starter-app', ['ngMaterial', 'ngRoute', Users.name])
	.config(($mdIconProvider, $mdThemingProvider) => {
		// Register the user `avatar` icons
		$mdIconProvider
			.defaultIconSet("./assets/svg/avatars.svg", 128)
			.icon("menu", "./assets/svg/menu.svg", 24)
			.icon("search", "./assets/svg/search.svg", 24)
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
			}).when("/results/:stopid", {
				title: "results",
				templateUrl: "src/templates/results/results.html",
				controller: "resultsController"
			});
	})
	.controller('AppController', AppController)
	.controller('homeController', homeController)
	.controller('resultsController', resultsController);

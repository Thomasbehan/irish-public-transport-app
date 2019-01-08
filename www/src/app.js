// Load libraries
import angular from 'angular';

import 'angular-animate';
import 'angular-aria';
import 'angular-material';
import 'angular-route';
import 'ngstorage';

import AppController from 'src/AppController';
import homeController from 'src/templates/home/home.controller';
import resultsController from 'src/templates/results/results.controller';
import settingsController from 'src/templates/settings/settings.controller';
import routesController from 'src/templates/routes/routes.controller';
import routesresultsController from 'src/templates/routesresults/routesresults.controller';
import Users from 'src/users/Users';

export default angular.module('starter-app', ['ngMaterial', 'ngRoute', 'ngStorage', Users.name])
    .config(($mdIconProvider, $mdThemingProvider) => {
        // Register the user `avatar` icons
        $mdIconProvider
            .defaultIconSet("./assets/svg/avatars.svg", 128)
            .icon("menu", "./assets/svg/menu.svg", 24)
            .icon("menu_outlined", "./assets/svg/outlined/menu.svg", 24)
            .icon("search", "./assets/svg/search.svg", 24)
            .icon("search_outlined", "./assets/svg/outlined/search.svg", 24)
            .icon("share", "./assets/svg/share.svg", 24)
            .icon("share_outlined", "./assets/svg/outlined/share.svg", 24)
            .icon("google_plus", "./assets/svg/google_plus.svg", 24)
            .icon("hangouts", "./assets/svg/hangouts.svg", 24)
            .icon("twitter", "./assets/svg/twitter.svg", 24)
            .icon("unfavourite", "./assets/svg/favorite.svg", 24)
            .icon("favourite", "./assets/svg/favorite-border.svg", 24)
            .icon("home", "./assets/svg/home.svg", 24)
            .icon("home_outlined", "./assets/svg/outlined/home.svg", 24)
            .icon("settings", "./assets/svg/settings.svg", 24)
            .icon("settings_outlined", "./assets/svg/outlined/settings.svg", 24)
            .icon("save", "./assets/svg/save.svg", 24)
            .icon("save_outlined", "./assets/svg/outlined/save.svg", 24)
            .icon("directions", "./assets/svg/directions.svg", 24)
            .icon("directions_outlined", "./assets/svg/outlined/directions.svg", 24)
            .icon("close_outlined", "./assets/svg/outlined/close.svg", 24)
            .icon("phone", "./assets/svg/phone.svg", 24);

        $mdThemingProvider.theme('default')
            .primaryPalette('blue')
            .accentPalette('red');
    }).config(function ($routeProvider) {
        $routeProvider
            .when("/", {
                title: "Home",
                templateUrl: "src/templates/home/home.html",
                controller: "homeController"
            }).when("/results/:stopid", {
                title: "Results",
                templateUrl: "src/templates/results/results.html",
                controller: "resultsController"
            }).when("/settings", {
                title: "Settings",
                templateUrl: "src/templates/settings/settings.html",
                controller: "settingsController"
            }).when("/routes", {
                title: "Routes",
                templateUrl: "src/templates/routes/routes.html",
                controller: "routesController"
            }).when("/routes/:operator/:routeid", {
                title: "Route Stops",
                templateUrl: "src/templates/routesresults/routesresults.html",
                controller: "routesresultsController"
            });
    })
    .controller('AppController', AppController)
    .controller('homeController', homeController)
    .controller('resultsController', resultsController)
    .controller('settingsController', settingsController)
    .controller('routesController', routesController)
    .controller('routesresultsController', routesresultsController);

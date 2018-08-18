'use strict';

var CreditApp = angular.module('CreditApp', ['ngRoute', 'Inicio','Panel']);
CreditApp.config(['$routeProvider',
    function (
        $routeProvider
    ) {
        $routeProvider.
            when('/Inicio', {
                templateUrl: 'pages/InicioPage.html',
                controller: 'InicioController'
            }).
            when('/Panel', {
                templateUrl: 'pages/PanelPage.html',
                controller: 'PanelController'
            }).
            otherwise({
                redirectTo: '/Inicio'
            });
    }]);

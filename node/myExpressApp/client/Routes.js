'use strict';

var EasyCredit = angular.module('EasyCredit', ['ngRoute', 'InicioSession', 'PanelSession', 'FormularioSession']);
EasyCredit.config(['$routeProvider',
    function (
        $routeProvider
    ) {
        $routeProvider.
            when('/InicioPage', {
                templateUrl: 'pages/InicioPage.html',
                controller: 'InicioSessionController'
            }).
            when('/PanelPage', {
                templateUrl: 'pages/PanelPage.html',
                controller: 'PanelSesssionController as main'
            }).
            when('/FormularioPage', {
                templateUrl: 'pages/FormularioPage.html',
                controller: 'FormularioSessionController'
            }).
            otherwise({
                redirectTo: '/InicioPage'
            });
    }]);
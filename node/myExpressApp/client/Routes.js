'use strict';

var EasyCredit = angular.module('EasyCredit', ['ngRoute', 'InicioSession','PanelSession']);
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
            otherwise({
                redirectTo: '/InicioPage'
            });
    }]);
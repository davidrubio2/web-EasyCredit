angular.module('PanelSessionAppService', [])
        .factory('PanelSessionService', ['$http', function ($http) {
                var handler = {
                        getHistorialSolicitudes: function (data) {
                                var url = 'api/consultarSolicitudHistorial'
                                return $http.post(url,data)
                },

        }

        return handler;
}]);	
angular.module('PanelSessionAppService', [])
        .factory('PanelSessionService', ['$http', function ($http) {
                var handler = {
                        getHistorialSolicitudes: function (data) {
                                var url = 'api/consultarSolicitudHistorial'
                                return $http.post(url,data)
                                
                },
                getSolicitudesPendientes: function (data) {
                        var url = 'api/consultarSolicitudesPendientes'
                        return $http.post(url,data)
                        
        },


        }

        return handler;
}]);	
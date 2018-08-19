angular.module('InicioSessionAppService', [])
        .factory('InicioSessionService', ['$http', function ($http) {
                var handler = {
                        IngresarService: function (data) {
                                var url = 'api/consultarGrabarUsuario'
                                return $http.post(url, data)
                        },
                }

                return handler;
        }]);


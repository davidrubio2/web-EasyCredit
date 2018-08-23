angular.module('FormularioSessionAppService', [])
        .factory('FormularioSessionService', ['$http', function ($http) {
                var handler = {
                        PostNuevaSolicitud: function (data) {
                                var url = 'api/nuevaSolicitud'
                                return $http.post(url, data)

                        },
                }

                return handler;
        }]);	
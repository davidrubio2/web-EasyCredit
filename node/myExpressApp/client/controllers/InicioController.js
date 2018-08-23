var InicioSession = angular.module("InicioSession", ['InicioSessionAppService']);
InicioSession.controller("InicioSessionController", ['$scope', 'InicioSessionService', function ($scope, InicioSessionService) {
        $scope.user_name = /^[a-zA-Z ]+$/;
        $scope.InicioSessionAppService = []
        $scope.Ingresar = function () {
                var data = {
                        "Username": $scope.username,
                }
                InicioSessionService.IngresarService(data).then(function (response) {
                        $scope.InicioSessionAppService.push(response.data)
                        $scope.Sessions = response.data;
                        location.href = "#/PanelPage?Id=" + $scope.Sessions.data[0].fun_consultargrabarusuario;
                });

        }
}]);


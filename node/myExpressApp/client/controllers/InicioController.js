var InicioSession = angular.module("InicioSession", ['InicioSessionAppService']);
InicioSession.controller("InicioSessionController", ['$scope', 'InicioSessionService', function ($scope, InicioSessionService) {
        $scope.first_name = /^[a-zA-Z ]+$/;
        $scope.InicioSessionAppService = []
        $scope.Ingresar = function () {
                var data = {
                        "Username": $scope.firstname,                
                }
                InicioSessionService.IngresarService(data).then(function (response) {
                         $scope.InicioSessionAppService.push(response.data)
                         $scope.Session = response.data;   
                });
			
        }
}]);


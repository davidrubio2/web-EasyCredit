var PanelSession = angular.module("PanelSession", ['PanelSessionAppService']);
PanelSession.controller("PanelSesssionController", ['$scope','PanelSessionService',  function ($scope,PanelSessionService) {
 

$scope.PanelSessionAppService = []


    function GetURLParameter(sParam)
    {
        var sPageURL = window.location.hash.substring(1); 
        var sURLVariables = sPageURL.split('?');
        for (var i = 0; i < sURLVariables.length; i++)
        {
            var sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] == sParam)
            {
                return sParameterName[1];
            }
        }
    }
    $scope.Id = GetURLParameter('Id');

            var data = {
                "Id": $scope.Id,                
        }
            PanelSessionService.getHistorialSolicitudes(data).then(function (response) {
                $scope.PanelSessionAppService.push(response.data)
                $scope.HistorialSolicitudes = response.data.data;
        });

        PanelSessionService.getSolicitudesPendientes(data).then(function (response) {
            $scope.PanelSessionAppService.push(response.data)
            $scope.SolicitudesPendientes = response.data.data;
     });

     $scope.Ingresar = function () {
                 location.href = "#/FormularioPage";
}


}]);
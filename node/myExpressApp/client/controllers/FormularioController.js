var FormularioSession = angular.module("FormularioSession", ['FormularioSessionAppService']);
FormularioSession.controller("FormularioSessionController", ['$scope', 'FormularioSessionService', function ($scope, FormularioSessionService) {

        $scope.FormularioSessionAppService = []

        $scope.calcularInteres = function () {
                var monto = $scope.monto;
                var plazo = $scope.plazo;
                var interes = plazo / 100;
                var total = monto * (1 + interes * 1);
                $scope.total = total;
        }
        function GetURLParameter(sParam) {
                var sPageURL = window.location.hash.substring(1);
                var sURLVariables = sPageURL.split('?');
                for (var i = 0; i < sURLVariables.length; i++) {
                        var sParameterName = sURLVariables[i].split('=');
                        if (sParameterName[0] == sParam) {
                                return sParameterName[1];
                        }
                }
        }
        $scope.Id = GetURLParameter('Id');


        $scope.Solicitar = function () {

                if ($scope.tieneTarjeta == true) {
                        var tieneTarjeta = "SI TIENE";
                }
                else {
                        var tieneTarjeta = "NO TIENE";
                }


                var data = {
                        "Id": $scope.Id,
                        "Monto": $scope.monto,
                        "Edad": $scope.edad,
                        "TarjetaDeCredito": tieneTarjeta,
                        "PlazoDeInteres": $scope.plazo + "%",
                }

                FormularioSessionService.PostNuevaSolicitud(data).then(function (response) {
                        $scope.FormularioSessionAppService.push(response.data)
                        $scope.NuevaSolicitud = response.data.data;
                });
                location.href = "#/PanelPage?Id=" + $scope.Id;
        }
}]);


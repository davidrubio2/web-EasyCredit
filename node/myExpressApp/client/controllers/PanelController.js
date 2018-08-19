var PanelSession = angular.module("PanelSession", []);
PanelSession.controller("PanelSesssionController", ['$scope',  function ($scope) {
 

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

}]);
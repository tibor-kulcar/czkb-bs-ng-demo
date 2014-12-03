app = angular.module 'app', []

app.controller 'MainController', ['$scope', ($scope) ->
    $scope.hello = 'Hello world'
]
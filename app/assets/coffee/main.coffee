app = angular.module 'app', []

app.controller 'MainController', ['$scope', '$http', ($scope, $http) ->
    $scope.hello = 'Hello world'
    $http.get('/api/me').success (result) ->
        console.log result
        $scope.hello = "Hello #{result.username}"
]

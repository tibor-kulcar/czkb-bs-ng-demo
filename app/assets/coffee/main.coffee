app = angular.module 'app', ['ngRoute']

app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when '/login/',
        templateUrl: 'templates/login.html'
        controller: 'MainController'
    .otherwise 
        templateUrl: 'templates/index.html'
        controller: 'MainController'    
]

app.controller 'MainController', ['$scope', '$http', ($scope, $http) ->
    $scope.hello = 'Hello world'
    $http.get('/api/me').success (result) ->
        console.log result
        $scope.hello = "Hello #{result.username}"
]

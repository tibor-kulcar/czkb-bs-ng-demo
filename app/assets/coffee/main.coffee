app = angular.module 'app', ['ngRoute']

app.config ($routeProvider) ->
    $routeProvider
        .when '/login/',
            templateUrl: 'templates/login.html'
            controller: 'MainController'
        .otherwise
            templateUrl: 'templates/index.html'
            controller: 'MainController'


app.controller 'MainController', ($scope, $http, $location, Tasks) ->
    $scope.hello = 'Hello world'
    $http.get('/api/me').success (result) ->
        console.log result
        $scope.hello = "Hello #{result.username}"
        Tasks.get().success (data) ->
            console.table(data)

    $scope.login = (username) ->
        console.log('Logging in ' + username)
        $http.post('/api/session', {username: username}).success (result) ->
            console.log('Logged in!')
            $location.path('/')

app.controller 'MenuController', ($scope, $http, $location) ->
    $scope.logout = ->
        console.log('Logging out')
        $http.delete('/api/session').success (result) ->
            console.log('Logged out!')
            $location.path('/')

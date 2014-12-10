app = angular.module 'app', ['ngRoute']

app.config ($routeProvider) ->
    $routeProvider
        .when '/login/',
            templateUrl: 'templates/login.html'
            controller: 'MainController'
        .when '/tasks/',
            templateUrl: 'templates/tasks.html'
            controller: 'MainController'
        .otherwise
            templateUrl: 'templates/index.html'
            controller: 'MainController'


app.controller 'MainController', ($scope, $http, $location, Tasks, User) ->
    $scope.hello = 'Hello world'

    User.get().success (result) ->
        $scope.hello = "Hello #{result.username}"
        $scope.avatar = result.avatar
        $scope.user = result
        Tasks.get().success (data) ->
            $scope.tasks = data
            console.table(data)

    $scope.todo = (task) ->
        return task.done == no

    $scope.login = (username) ->
        User.login(username)

app.controller 'MenuController', ($scope, $http, $location, User) ->
    $scope.logout = ->
        console.log('Logging out')
        User.logout()

    $scope.isLogged = () ->
        return User.isLogged()

    User.get().success (result) ->
        $scope.user = result

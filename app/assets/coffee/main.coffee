app = angular.module 'app', ['ngRoute', 'ngResource', 'ngAnimate']

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


app.controller 'MainController', ($scope, $http, $location, $timeout, Tasks, User) ->
    $scope.hello = 'Hello world'

    User.get().success (result) ->
        $scope.hello = "Hello #{result.username}"
        $scope.avatar = result.avatar
        $scope.user = result
        Tasks.query((data) ->
            $scope.tasks = data
        )

    $scope.todo = (task) ->
        return task.done == no

    $scope.done = (task) ->
        return task.done == yes

    $scope.unassigned = (task) ->
        return task.assignee == null || task.recent == true

    $scope.login = (username) ->
        User.login(username)

    $scope.isLogged = () ->
        return User.isLogged()

    $scope.finishTask = (task) ->
        task.recent = true
        task.done = true
        Tasks.finish({id: task.id})
        $timeout () ->
            task.recent = false
        , 4000

    $scope.unfinishTask = (task) ->
        task.recent = false
        task.done = false
        Tasks.unfinish({id: task.id})

    $scope.$watch('isLogged()', (value) ->
        if (value)
            console.log('Logged in, load everything')
            User.get().success (result) ->
                $scope.hello = "Hello #{result.username}"
                $scope.avatar = result.avatar
                $scope.user = result
                Tasks.query((data) ->
                    $scope.tasks = data
                    console.table(data)
                )
    )

    $scope.assignTask = (task, user) ->
        console.log('assign task'+task+' to user + '+user)
        task.assignee = parseInt(user.id)
        task.recent = true
        Tasks.assign({id: task.id}, task)
        $timeout ->
            task.recent = false
        , 4000

    $scope.unassignTask = (task) ->
        task.assignee = null
        task.recent = false
        Tasks.assign({id: task.id}, task)

app.controller 'MenuController', ($scope, $http, $location, User) ->
    $scope.logout = ->
        console.log('Logging out')
        User.logout()

    $scope.isLogged = () ->
        return User.isLogged()


    $scope.$watch('isLogged()', (value) ->
        if (value)
            console.log('Logged in, load menu')
            User.get().success (result) ->
                $scope.user = result
    )

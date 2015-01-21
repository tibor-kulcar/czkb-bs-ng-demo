app = angular.module 'app', ['ngRoute', 'ngResource', 'ngAnimate']

app.constant 'CONFIG', {
    undoTimeout: 10000
  }

app.config ($routeProvider) ->
    $routeProvider
        .when '/login/',
            templateUrl: 'templates/login.html'
            controller: 'MainControler'
        .when '/tasks/',
            templateUrl: 'templates/tasks.html'
            controller: 'MainController'
        .otherwise
            templateUrl: 'templates/index.html'
            controller: 'MainController'


app.controller 'MainController', ($scope, $http, $location, $timeout, Tasks, User, CONFIG) ->
    $scope.hello = 'Hello world'
    $scope.showAll = false

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

    $scope.finishTask = (task, child) ->
        task.recent = true
        task.done = true
        child.balance.amount += task.reward
        Tasks.finish({id: task.id})
        $timeout () ->
            task.recent = false
        , CONFIG.undoTimeout

    $scope.unfinishTask = (task, child) ->
        task.recent = false
        task.done = false
        child.balance.amount -= task.reward
        if (child.balance.amount < 0)
            child.balance.amount = 0
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
        task.assigneeName = user.name
        task.recent = true
        Tasks.assign({id: task.id}, task)
        $timeout ->
            task.recent = false
        , CONFIG.undoTimeout

    $scope.unassignTask = (task) ->
        task.assignee = null
        task.recent = false
        Tasks.assign({id: task.id}, task)
        
    $scope.createTask = (newtask) ->
        newtask.done = false
        newtask.assignee = null
        
        Tasks.save(newtask).$promise.then(() ->
        	Tasks.query((data) ->
        		$scope.tasks = data
        	)
        	newtask = {}
        )

app.controller 'MenuController', ($scope, $http, $location, User) ->
    $scope.theme = 'cyborg'

    $scope.themes = ['cerulean',
                     'cosmo',
                     'cyborg',
                     'darkly',
                     'flatly',
                     'fonts',
                     'journal',
                     'lumen',
                     'paper',
                     'readable',
                     'sandstone',
                     'simplex',
                     'slate',
                     'spacelab',
                     'superhero',
                     'united',
                     'yeti' ]

    $scope.setTheme = (t) ->
    	$scope.theme = t
    	
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

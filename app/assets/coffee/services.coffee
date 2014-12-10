app = angular.module 'app'

app.service 'Tasks', ($http, $q) ->
    URI = 'api/me/tasks'
    _instance = {}

    _instance.get = () ->
        return $http.get(URI)

    return _instance

app.service 'User', ($http, $q, $location, $route) ->
    URI = 'api/me'
    loggedIn = false

    _instance = {}

    _instance.get = () ->
        promise = $http.get(URI)
        promise.success () ->
            loggedIn = true
        return promise

    _instance.isLogged = () ->
        return loggedIn

    _instance.logout = () ->
        $http.delete('/api/session').success (result) ->
            console.log('Logged out!')
            loggedIn = false
            $location.path('/')
            $route.reload()

    _instance.login = (username) ->
        console.log('Logging in ' + username)
        $http.post('/api/session', {username: username}).success (result) ->
            console.log('Logged in!')
            $location.path('/')
            loggedIn = true

    return _instance

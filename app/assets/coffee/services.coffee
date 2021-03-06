app = angular.module 'app'

app.service 'Tasks', ($resource) ->
    _URI = 'api/me/tasks/:taskId/:action'
    _instance = $resource(_URI, {taskId: '@id'}, {
        finish: {method: 'POST', params: {action: 'done'}},
        unfinish: {method: 'POST', params: {action: 'undone'}},
        assign: {method: 'POST', params: {action: 'assign'}}
    })
    return _instance

app.service 'User', ($http, $q, $location, $route) ->
    URI = 'api/me'
    loggedIn = false
    _promise = null

    _instance = {}

    _instance.get = () ->
        if (loggedIn && _promise)
            return _promise
        else
            promise = $http.get(URI)
            promise.success (profile) ->
                loggedIn = true
                _promise = promise
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

app = angular.module 'app'

app.service 'Tasks', ($http, $q) ->
    URI = 'api/me/tasks'
    _instance = {}

    _instance.get = () ->
        return $http.get(URI)

    return _instance

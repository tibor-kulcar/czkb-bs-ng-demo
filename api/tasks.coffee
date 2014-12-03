
module.exports = (app) ->
    # mock task list
    taskList = [
                id: 1
                name: 'Ukol cislo 1'
                description: 'Task definition'
            ,
                id: 2
                name: 'Ukol cislo 2'
                description: 'Task more specific definition'
            ,
                id: 3
                name: 'Ukol cislo 3'
                description: 'Task more more specific definition'
            ]


    app.get '/api/tasks', (req, res) ->
        res.send 
            taskList: taskList


    app.post '/api/tasks', (req, res) ->
        taskList.push
            id: 69
            name: 'Pridany ukol'
            description: 'Added task'
        res.status(204).end()


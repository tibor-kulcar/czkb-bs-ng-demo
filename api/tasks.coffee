router = require('express').Router()

# mock task list
taskList =
    1:
        id: 1
        name: 'Ukol cislo 1'
        description: 'Task definition'
    2:
        id: 2
        name: 'Ukol cislo 2'
        description: 'Task more specific definition'
    3:
        id: 3
        name: 'Ukol cislo 3'
        description: 'Task more more specific definition'


router.get '/', (req, res) ->
    res.send(task for task_id, task of taskList)


router.post '/', (req, res) ->
    task =
        id: req.body.id
        name: req.body.name
        description: req.body.description
    taskList[task.id] = task
    res.send(task)


module.exports = router

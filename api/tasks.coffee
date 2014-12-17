router = require('express').Router()
_ = require('lodash')

# mock task list
taskList =
    1:
        id: 1
        name: 'Ukol cislo 1'
        description: 'Task definition'
        done: true
        reward: 50
        assignee: 2
    2:
        id: 2
        name: 'Ukol cislo 2'
        description: 'Task more specific definition'
        done: false
        reward: 550
        assignee: 1
    3:
        id: 3
        name: 'Ukol cislo 3'
        description: 'Task more more specific definition'
        done: false
        reward: 320
        assignee: null


router.get '/', (req, res) ->
    res.send(task for task_id, task of taskList)

router.get '/:taskId',  (req, res) ->
    console.log('Looking for task: ' + req.param('taskId'))
    task = _findTask(req.param('taskId'))
    res.send(task)

router.post '/:taskId', (req, res) ->
    console.log('Updating task: ' + req.param('taskId'))
    task = _findTask(req.param('taskId'))
    task.id = req.body.id
    task.name = req.body.name
    task.description = req.body.description
    task.reward = req.body.reward
    res.send(task)

router.post '/:taskId/done', (req, res) ->
    console.log('Finishing task: ' + req.param('taskId'))
    task = _findTask(req.param('taskId'))
    task.done = true
    res.send(task)

router.post '/:taskId/assign', (req, res) ->
    console.log('Assigning task: ' + req.param('taskId'))
    task = _findTask(req.param('taskId'))
    task.assignee = req.body.assignee
    res.send(task)


router.post '/', (req, res) ->
    task =
        id: req.body.id
        name: req.body.name
        description: req.body.description
        reward: req.body.reward
        done: false
        assignee: null
    taskList[task.id] = task
    res.send(task)

_findTask = (taskId) ->
    return _.find(taskList, (t) ->
        return parseInt(t.id) == parseInt(taskId)
    )


module.exports = router

router = require('express').Router()
_ = require('lodash')

# mock task list
taskList =
    1:
        id: 1
        name: 'Vynést koš'
        description: 'Už se tu nedá dýchat'
        done: false
        reward: 50
        assignee: null
    2:
        id: 2
        name: 'Nakrmit psa'
        description: 'Granule jsou ve sklepě'
        done: false
        reward: 550
        assignee: null
    3:
        id: 3
        name: 'Nakrmit rybičky'
        description: 'Krmení se musí koupit'
        done: false
        reward: 320
        assignee: null
    4:
        id: 4
        name: 'Posekat trávník'
        description: 'Sekačku půjčit od souseda'
        done: false
        reward: 220
        assignee: null
    5:
        id: 5
        name: 'Umýt nádobí'
        description: 'Nezacákat celou kuchyň'
        done: false
        reward: 50
        assignee: null
    6:
        id: 6
        name: 'Oloupat a nakrájet cibuli k večeři'
        description: 'na kostičky, cca 1cm'
        done: false
        reward: 120
        assignee: null
    7:
        id: 7
        name: 'Uklidit si pokoj'
        description: 'a nezapomeň si ustlat!'
        done: false
        reward: 200
        assignee: null
    8:
        id: 8
        name: 'Umýt auto'
        description: 'už je jako prase'
        done: false
        reward: 500
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

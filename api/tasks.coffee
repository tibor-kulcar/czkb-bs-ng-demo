router = require('express').Router()
_ = require('lodash')
children = require('./me').children

# mock task list
taskList =
    1:
        id: 1
        name: 'Vynést koš'
        description: 'Už se tu nedá dýchat'
        done: false
        reward: 5
        assignee: 1
    2:
        id: 2
        name: 'Nakrmit psa'
        description: 'Granule jsou ve sklepě'
        done: false
        reward: 10
        assignee: 2
    3:
        id: 3
        name: 'Nakrmit rybičky'
        description: 'Krmení se musí koupit'
        done: false
        reward: 15
        assignee: 1
    4:
        id: 4
        name: 'Posekat trávník'
        description: 'Sekačku půjčit od souseda'
        done: false
        reward: 25
        assignee: null
    5:
        id: 5
        name: 'Umýt nádobí'
        description: 'Nezacákat celou kuchyň'
        done: false
        reward: 10
        assignee: null
    6:
        id: 6
        name: 'Oloupat a nakrájet cibuli k večeři'
        description: 'na kostičky, cca 1cm'
        done: false
        reward: 10
        assignee: null
    7:
        id: 7
        name: 'Uklidit si pokoj'
        description: 'a nezapomeň si ustlat!'
        done: false
        reward: 5
        assignee: null
    8:
        id: 8
        name: 'Umýt auto'
        description: 'už je jako prase'
        done: false
        reward: 20
        assignee: null
    9:
        id: 9
        name: 'Naštípat dříví'
        description: 'pozor, sekyra je nabroušená!'
        done: false
        reward: 20
        assignee: null
    10:
        id: 10
        name: 'Zalít zahradu'
        description: 'vodu nechat odstát'
        done: false
        reward: 10
        assignee: null




router.get '/', (req, res) ->
    res.send(task for task_id, task of taskList)

router.get '/:taskId', (req, res) ->
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
    task = _findTask(req.param('taskId'))
    console.log("Finishing task: #{req.param('taskId')} for #{task.assignee}")
    task.done = true
    assignee = _findChild(task.assignee)
    assignee.balance.amount += task.reward
    res.send(task)

router.post '/:taskId/undone', (req, res) ->
    task = _findTask(req.param('taskId'))
    console.log("Returning task: #{req.param('taskId')} for #{task.assignee}")
    task.done = false
    assignee = _findChild(task.assignee)
    assignee.balance.amount -= task.reward
    res.send(task)


router.post '/:taskId/assign', (req, res) ->
    console.log("Assigning task: #{req.param('taskId')} to #{req.body.assignee}")
    task = _findTask(req.param('taskId'))
    task.assignee = req.body.assignee
    res.send(task)


router.post '/', (req, res) ->
    task =
        id: _nextId()
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

_nextId = () ->
    max = _.max taskList, (t) ->
        return t.id
    return max + 1


_findChild = (childId) ->
    return _.find(children, (c) ->
        return parseInt(c.id) == parseInt(childId)
    )



module.exports = router

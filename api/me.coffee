router = require('express').Router()
_ = require('lodash')
router.use require('./session').loginRequired

router.children = [{
  id: 1
  name: 'Katka'
  avatar: 'https://s3.amazonaws.com/uifaces/faces/twitter/kfriedson/73.jpg'
  balance:
      amount: 15
      currency: 'CZK'
  target:
      amount: 150
      currency: 'CZK'
} , {
  id: 2
  name: 'Tim'
  avatar: 'https://s3.amazonaws.com/uifaces/faces/twitter/timmillwood/73.jpg'
  balance:
      amount: 5
      currency: 'CZK'
  target:
      amount: 100
      currency: 'CZK'
} ]

router.get '/', (req, res) ->
    res.send
        username: req.session.username
        name: 'Jan Novák'
        avatar: 'https://s3.amazonaws.com/uifaces/faces/twitter/c_southam/73.jpg'
        children: router.children
        resources: [
            {
                name: 'account'
                uri: '/me/account'
                description: 'Account information'
            } , {
                name: 'tasks'
                uri: 'me/tasks'
                description: 'Task list'
            }
        ]

router.get '/child/:childId', (req, res) ->
    res.send(_findChild(req.param('childId')))

_findChild = (childId) ->
    return _.find(router.children, (c) ->
        return parseInt(c.id) == parseInt(childId)
    )

module.exports = router

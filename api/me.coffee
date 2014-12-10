router = require('express').Router()
router.use require('./session').loginRequired

router.get '/', (req, res) ->
    res.send
        username: req.session.username
        name: 'Jan Novák'
        resources: [
            {
                name: 'account'
                uri: '/me/account'
                description: 'Account information'
            }, {
                name: 'tasks'
                uri: 'me/tasks'
                description: 'Task list'
            }
        ]

router.get '/account', (req, res) ->
    res.send
        ammount: 100
        currency: 'CZK'

module.exports = router

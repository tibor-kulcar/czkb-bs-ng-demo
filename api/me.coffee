router = require('express').Router()
router.use require('./session').loginRequired

router.get '/', (req, res) ->
    res.send
        username: req.session.username
        name: 'Jan Novák'
        avatar: 'https://s3.amazonaws.com/uifaces/faces/twitter/c_southam/73.jpg'
        children: [
            {
                id: 1
                name: 'Katka'
                avatar: 'https://s3.amazonaws.com/uifaces/faces/twitter/kfriedson/73.jpg'
                account:
                    amount: 100
                    currency: 'CZK'
            },
            {
                id: 2
                name: 'Tim'
                avatar: 'https://s3.amazonaws.com/uifaces/faces/twitter/timmillwood/73.jpg'
                account:
                    amount: 200
                    currency: 'CZK'

            }
        ]
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

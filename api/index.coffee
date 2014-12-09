router = require('express').Router()
errorHandler = require('./error-handler')

router.get '/', (req, res) ->
    res.send 
        resources: [
            name: 'user'
            uri: '/me'
            description: 'Current user information'
        ]

router.use '/session', require('./session')
router.use '/me', require('./me')

# API EXAMPLE


# SIMPLE LOGIN / LOGOUT PAGES FOR TESTING
# LOGIN / LOGOUT
router.get '/api-logout', (req, res) ->
    req.session.destroy(
        res.redirect '/api-login'
    )

(require './tasks')(router)

router.use errorHandler.middleware

module.exports = router

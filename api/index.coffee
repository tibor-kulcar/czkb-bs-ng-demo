router = require('express').Router()
errorHandler = require('./error-handler')

# MIDDLEWARES
session      = require 'express-session'
bodyParser   = require 'body-parser'
router.use bodyParser.json()
router.use bodyParser.urlencoded({ extended: true })
router.use session
    secret: 'some secret'
    resave: false
    saveUninitialized: true


# API
router.get '/', (req, res) ->
    res.send 
        resources: [
                name: 'user'
                uri: '/api/me'
                description: 'Current user information'
            ,
                name: 'session'
                uri: '/api/session'
                description: 'Session management including login and logout'
        ]

router.use '/session', require('./session')
router.use '/me', require('./me')
router.use '/me/tasks', require('./tasks')


# SIMPLE LOGIN / LOGOUT PAGES FOR TESTING
# LOGIN / LOGOUT
router.get '/api-logout', (req, res) ->
    req.session.destroy(
        res.redirect '/api-login'
    )

router.use errorHandler.middleware

module.exports = router

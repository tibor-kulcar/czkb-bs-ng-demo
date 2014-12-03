module.exports = (app) ->
    session      = require 'express-session'
    bodyParser   = require 'body-parser'

    app.use session
        secret: 'some secret'
        resave: false
        saveUninitialized: true

    app.use bodyParser.json()
    app.use bodyParser.urlencoded({ extended: true })

    # LIST OF RESOURCES
    app.get '/api', (req, res) ->
        res.send 
            resources: [
                name: 'user'
                uri: '/me'
                description: 'Current user information'
            ]


    # LOGIN
    app.post '/api/login', (req, res) ->
        sess = req.session
        if req.body.username
            sess.username = req.body.username
            sess.save()
        res.status(204).end()

    loginRequired =  (req, res, next) ->
        if not req.session.username
            res.status(403).end()
        else
            next()

    # API EXAMPLE
    app.use '/api/me', loginRequired

    app.get '/api/me', (req, res) ->
        res.send 
            username: req.session.username
            name: 'Jan Novák'
            resources: [
                name: 'account'
                uri: '/me/account'
                description: 'Account information'
            ]

    app.get '/api/me/account', (req, res) ->
        res.send
            ammount: 100
            currency: 'CZK'


    # SIMPLE LOGIN / LOGOUT PAGES FOR TESTING
    # LOGIN / LOGOUT
    app.get '/api-logout', (req, res) ->
        req.session.destroy(
            res.redirect '/api-login'
        )

    app.get '/api-login', (req, res) ->
        username = req.session.username or ""
        if username
            res.redirect '/api-logout'
        else
            res.send "
                <form method='post' action='/api/login'>
                    <input name='username' placeholder='Jméno' value='#{username}' />
                    <button>Přihlásit se</button>
                </form>
            "

    (require './tasks')(app)

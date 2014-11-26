#!/usr/bin/env coffee
PORT = 8000
PROJECT_ROOT = __dirname

print = console.log.bind(console)

express = require 'express'
bodyParser = require 'body-parser'
errorHandler = require 'errorhandler'
path = require 'path'

app = express()

app.use bodyParser.json()
# app.use(express.methodOverride()
app.use express.static(path.join(PROJECT_ROOT, "app"), {index: ['index.html', 'index.html', ]})
app.use errorHandler({ dumpExceptions: true, showStack: true })

app.get '/', (req, res) ->
    res.end()

app.get '/api', (req, res) ->
    res.send 
        resources: [
            name: 'user'
            uri: '/me'
            description: 'Current user information'
        ]

app.get '/api/me', (req, res) ->
    res.send 
        resources: [
            name: 'account'
            uri: '/me/account'
            description: 'Account information'
        ]

app.get '/api/me/account', (req, res) ->
    res.send
        name: 'Rodič Rodičov'
        ammount: 100
        currency: 'CZK'

print 'Listening on prot %s', PORT
app.listen PORT

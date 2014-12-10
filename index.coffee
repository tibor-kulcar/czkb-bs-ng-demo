#!/usr/bin/env coffee
PORT = process.env.PORT or 8000
PROJECT_ROOT = __dirname
DEBUG = true

print = console.log.bind(console)

express      = require 'express'
errorHandler = require 'errorhandler'
path         = require 'path'
params       = require 'express-params'

app = express()

params.extend(app)

# http 500 error on exception
app.use errorHandler({ dumpExceptions: DEBUG, showStack: DEBUG })

# serve static files
app.use express.static(path.join(PROJECT_ROOT, "app"), {index: ['index.html', 'index.html', ]})

app.use '/api', require('./api')

print 'Listening on prot %s', PORT
app.listen PORT

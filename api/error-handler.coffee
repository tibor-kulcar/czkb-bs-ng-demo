router = require('express').Router()

HttpError = (options) ->
    err = new Error()
    err.status = options['status']
    err.error = options['error']
    err.description = options['description']
    return err


middleware = (err, req, res, next) ->
    status = err.status or 500
    res.status(status).send
        status: status
        error: err.error or "error"
        description: err.description or "Něco se pokazilo."
    throw err

module.exports = 
    HttpError: HttpError
    middleware: middleware


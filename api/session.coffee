# SESSION (login / logout)
router = require('express').Router()

router.get '/new', (req, res) ->
    username = req.session.username or ""
    res.send "
        <form method='post' action='/api/session'>
            <input name='username' placeholder='Jméno' value='#{username}' />
            <button>Přihlásit se</button>
        </form>
    "

router.post '/', (req, res) ->
    sess = req.session
    if req.body.username
        sess.username = req.body.username
        sess.save()
    res.status(204).end()

router.delete '/', (req, res) ->
    req.session.destroy(
        res.status(204).end()
    )

router.loginRequired = (req, res, next) ->
    if not req.session.username
        res.status(403).end()
    else
        next()

module.exports = router

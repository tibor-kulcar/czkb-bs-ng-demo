# SESSION (login / logout)
router = require('express').Router()
HttpError = require('./error-handler').HttpError


router.get '/', (req, res) ->
    sess = req.session
    if sess.username
        res.send(sess)
    else
        throw HttpError
            status: 404
            error: "not found"
            description: '''Žádné sezení nebylo dosud vytořeno. Vytvořte nové odesláním username (POST ./)
                nebo potvrzením formuláře (GET ./new).'''

router.post '/', (req, res) ->
    sess = req.session
    if req.body.username
        sess.username = req.body.username
        sess.save()
    res.status(204).end()

router.delete '/', (req, res) ->
    req.session.destroy()
    res.status(204).end()

# returns login form (mainly for testing purpose)
router.get '/new', (req, res) ->
    username = req.session.username or ""
    res.send "
        <form method='post' action='/api/session'>
            <input name='username' placeholder='Jméno' value='#{username}' />
            <button>Přihlásit se</button>
        </form>
    "

router.loginRequired = (req, res, next) ->
    if not req.session.username
        throw HttpError
            status: 403
            error: "Forbidden"
            description: "Pro přístup do této části API musíte být přihlášen."
    else
        next()



module.exports = router

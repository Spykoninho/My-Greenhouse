const express = require('express')
const router = express.Router()
const usersController = require('../controller/usersController')
const UsersController = new usersController()
const isLogged = require('../middlewares/isLogged')

// GET
router.get('/api/getMyInfos', [isLogged], UsersController.getMyInfos)

// POST

router.post('/api/signIn', UsersController.signIn)

router.post('/api/login', UsersController.logIn)

router.post('/api/setOneSignalId', [isLogged], UsersController.setOneSignalId)

module.exports = router
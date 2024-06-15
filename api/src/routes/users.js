const express = require('express')
const router = express.Router()
const usersController = require('../controller/usersController')
const UsersController = new usersController()

router.post('/api/signIn', UsersController.signIn)

router.post('/api/login', UsersController.logIn)

module.exports = router
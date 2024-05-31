const express = require('express')
const router = express.Router()
const usersController = require('../controller/usersController')
const UsersController = new usersController()

router.get('/test/:ok', UsersController.test)

module.exports = router
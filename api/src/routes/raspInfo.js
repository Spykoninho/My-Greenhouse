const express = require('express')
const router = express.Router()
const greenhouseController = require('../controller/greenhouseController')
const GreenhouseController = new greenhouseController()
const isLogged = require('../middlewares/isLogged')

router.post('/api/saveGreenhouseData', GreenhouseController.saveGreenhouseData)

router.post('/api/addGreenhouse', [isLogged] ,GreenhouseController.addGreenhouse)

module.exports = router
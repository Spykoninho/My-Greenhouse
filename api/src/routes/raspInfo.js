const express = require('express')
const router = express.Router()
const greenhouseController = require('../controller/greenhouseController')
const GreenhouseController = new greenhouseController()

router.post('/api/saveGreenhouseData', GreenhouseController.saveGreenhouseData)

router.post('/api/addGreenhouse', GreenhouseController.addGreenhouse)

module.exports = router
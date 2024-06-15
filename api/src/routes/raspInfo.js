const express = require('express')
const router = express.Router()
const raspInfoController = require('../controller/raspInfoController')
const RaspInfoController = new raspInfoController()

router.post('/api/saveGreenhouseData', RaspInfoController.saveGreenhouseData)

module.exports = router
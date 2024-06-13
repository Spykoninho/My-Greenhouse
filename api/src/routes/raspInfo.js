const express = require('express')
const router = express.Router()
const raspInfoController = require('../controller/raspInfoController')
const RaspInfoController = new raspInfoController()

module.exports = router
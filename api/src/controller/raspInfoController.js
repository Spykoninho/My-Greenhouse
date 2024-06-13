const raspInfoService = require('../service/raspInfoService');

class RaspInfoController{
    service;
    constructor(){
        this.service = new raspInfoService()
    }

}

module.exports = RaspInfoController
var jsonwebtoken = require('jsonwebtoken');
const raspInfoRepository = require('../repository/raspInfoRepository')
const utilService = require('./utilService')

class RaspInfoService{
    repo;
    util;
    constructor(){
        this.repo = new raspInfoRepository();
        this.util = new utilService();
    }
    
}

module.exports = RaspInfoService
var jsonwebtoken = require('jsonwebtoken');
const raspInfoRepository = require('../repository/greenhouseRepository')
const utilService = require('./utilService')

class Greenhouseservice{
    repo;
    util;
    constructor(){
        this.repo = new raspInfoRepository();
        this.util = new utilService();
    }
    
    async saveGreenhouseDataService(body, userInfos){
        try {
            console.log(body)
            console.log(userInfos)
            let resDb = await this.repo.saveGreenhouseDataRepo();
            return true
        } catch (error) {
            console.log("error at @saveGreenhouseDataService : " + error)
            return {error: "Une erreur est survenue durant la sauvegarde des informations de la serre"}
        }
    }
}

module.exports = Greenhouseservice
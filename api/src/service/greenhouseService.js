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

    async addGreenhouseService(body, userInfos){
        try {
            let greenhouse_name = body.greenhouse_name;
            if(greenhouse_name && greenhouse_name.length > 0){
                let resDb = await this.repo.addGreenhouseRepo(greenhouse_name, userInfos.id);
                if(resDb.affectedRows > 0) return true
                else return {error: "Une erreur est survenue durant l'ajout de la serre"}
            }else return {error: "Body incomplet"}
        } catch (error) {
            console.log("error at @addGreenhouseService : " + error)
            return {error: "Une erreur est survenue durant l'ajout de la serre"}
        }
    }
}

module.exports = Greenhouseservice
var jsonwebtoken = require('jsonwebtoken');
const raspInfoRepository = require('../repository/greenhouseRepository')
const utilService = require('./utilService')
const userService = require('./usersServices')

class Greenhouseservice{
    repo;
    util;
    constructor(){
        this.repo = new raspInfoRepository();
        this.util = new utilService();
        this.user = new userService();
    }
    
    async saveGreenhouseDataService(body, userInfos){
        try {
            let idGreenhouse = body.idGreenhouse
            let humidity = body.humidity
            let soil_humidity = body.soil_humidity
            let temperature = body.temperature
            let feel_temperature = body.feel_temperature
            if(!idGreenhouse || !humidity || !soil_humidity || !temperature || !feel_temperature) return  {error: "Body incomplet"}
            humidity=parseInt(humidity)
            soil_humidity=parseInt(soil_humidity)
            temperature=parseInt(temperature)
            feel_temperature=parseInt(feel_temperature)
            var currentdate = new Date(); 
            var datetime = currentdate.getFullYear()+"-"+currentdate.getMonth()+"-"+currentdate.getDate()+" "+currentdate.getHours()+":"+currentdate.getMinutes()+":"+currentdate.getSeconds()
            console.log(datetime)
            let resDb = await this.repo.saveGreenhouseDataRepo(idGreenhouse, humidity, soil_humidity, temperature, feel_temperature, datetime);
            if(resDb.affectedRows < 1) return {error: "Une erreur est survenue durant la sauvegarde des informations de la serre"}
            let resUser = await this.user.getMyInfosService(userInfos.id)
            if(humidity >= resUser.max_air_humidity){
                console.log("Alerte humidité de l'air trop élevée")
                // envoyer la notif
            }
            if(humidity <= resUser.min_air_humidity){
                console.log("Alerte humidité de l'air trop basse")
                // envoyer la notif
            }
            if(soil_humidity >= resUser.max_soil_humidity){
                console.log("Alerte humidité du sol trop élevée")
                // envoyer la notif
            }
            if(soil_humidity <= resUser.min_soil_humidity){
                console.log("Alerte humidité du sol trop basse")
                // envoyer la notif
            }
            if(temperature >= resUser.max_temperature){
                console.log("Alerte température trop élevée")
                // envoyer la notif
            }
            if(temperature <= resUser.min_temperature){
                console.log("Alerte température trop basse")
                // envoyer la notif
            }
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
                if(greenhouse_name.length > 255) return {error: "Nom trop long"}
                let resDb = await this.repo.addGreenhouseRepo(greenhouse_name, userInfos.id);
                if(resDb[0].id){
                    console.log(resDb)
                    return resDb[0].id
                } 
                else{
                    console.log("error at @addGreenhouseService : " + resDb)
                    return {error: "Une erreur est survenue durant l'ajout de la serre"}
                } 
            }else return {error: "Body incomplet"}
        } catch (error) {
            console.log("error at @addGreenhouseService : " + error)
            return {error: "Une erreur est survenue durant l'ajout de la serre"}
        }
    }
}

module.exports = Greenhouseservice
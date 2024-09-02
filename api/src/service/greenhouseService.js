var jsonwebtoken = require('jsonwebtoken');
const raspInfoRepository = require('../repository/greenhouseRepository')
const utilService = require('./utilService')
const userService = require('./usersServices')

class Greenhouseservice {
    repo;
    util;
    constructor() {
        this.repo = new raspInfoRepository();
        this.util = new utilService();
        this.user = new userService();
    }

    async saveGreenhouseDataService(body, userInfos) {
        try {
            let idGreenhouse = body.idGreenhouse
            let humidity = body.humidity
            let soil_humidity = body.soil_humidity
            let temperature = body.temperature
            let feel_temperature = body.feel_temperature
            if (!idGreenhouse || !humidity || !soil_humidity || !temperature || !feel_temperature) return { error: "Body incomplet" }
            if (soil_humidity < 0) return { error: "Valeur incohérente" }
            humidity = parseInt(humidity)
            soil_humidity = parseInt(soil_humidity)
            temperature = parseInt(temperature)
            feel_temperature = parseInt(feel_temperature)
            var currentdate = new Date();
            var month = (currentdate.getMonth() == 12 ? '01' : currentdate.getMonth() + 1)
            var hours;
            if (currentdate.getHours() >= 22) {
                hours = (currentdate.getHours() == 22 ? '00' : '01')
            } else {
                hours = currentdate.getHours() + 2
            }
            var datetime = currentdate.getFullYear() + "-" + month + "-" + currentdate.getDate() + " " + hours + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds()
            let resDb = await this.repo.saveGreenhouseDataRepo(idGreenhouse, humidity, soil_humidity, temperature, feel_temperature, datetime);
            if (resDb.affectedRows < 1) return { error: "Une erreur est survenue durant la sauvegarde des informations de la serre" }
            const url = 'https://api.onesignal.com/notifications?c=push'
            let resUser = await this.user.getMyInfosService(userInfos.id)
            let bodyJson = {
                app_id: process.env.ONESIGNAL_APP_ID,
                include_external_user_ids: [resUser.onesignal_id]
            }
            let options = {
                method: 'POST',
                headers: {
                    accept: 'application/json', 'content-type': 'application/json',
                    Authorization: `Basic ${process.env.ONESIGNAL_API_KEY}`
                },
            };

            if (resUser.notifications == 1) {

                if (humidity >= resUser.max_air_humidity && resUser.notif_air_humidity == 0) {
                    await this.repo.changeNotifStatus("notif_air_humidity", 1, userInfos.id);
                    bodyJson.template_id = 'bfdaacbd-eedb-4c5a-8068-c3fa2edcfc14';
                    options.body = JSON.stringify(bodyJson)
                    let resFetch = await fetch(url, options);
                    console.log(await resFetch.json())
                } else if (humidity < (resUser.max_air_humidity - 1) && humidity > resUser.min_air_humidity) {
                    await this.repo.changeNotifStatus("notif_air_humidity", 0, userInfos.id);
                }
                if (humidity <= resUser.min_air_humidity && resUser.notif_air_humidity == 0) {
                    await this.repo.changeNotifStatus("notif_air_humidity", 1, userInfos.id);
                    bodyJson.template_id = 'e188a29c-7433-4718-87e3-f38b98fd9e08';
                    options.body = JSON.stringify(bodyJson)
                    let resFetch = await fetch(url, options);
                    console.log(await resFetch.json())
                } else if (humidity > (resUser.min_air_humidity + 1) && humidity < resUser.max_air_humidity) {
                    await this.repo.changeNotifStatus("notif_air_humidity", 0, userInfos.id);
                }
                if (soil_humidity >= resUser.max_soil_humidity && resUser.notif_soil_humidity == 0) {
                    await this.repo.changeNotifStatus("notif_soil_humidity", 1, userInfos.id);
                    bodyJson.template_id = '38925c1b-a7e1-434f-ae8f-9efa46d48ed5';
                    options.body = JSON.stringify(bodyJson)
                    let resNotif = await fetch(url, options);
                    console.log(await resNotif.json())
                } else if (soil_humidity < (resUser.max_soil_humidity - 1) && soil_humidity > resUser.min_soil_humidity) {
                    await this.repo.changeNotifStatus("notif_soil_humidity", 0, userInfos.id);
                }
                if (soil_humidity <= resUser.min_soil_humidity && resUser.notif_soil_humidity == 0) {
                    await this.repo.changeNotifStatus("notif_soil_humidity", 1, userInfos.id);
                    bodyJson.template_id = '027bed70-f55f-4f13-803f-ddbb4fea191e';
                    options.body = JSON.stringify(bodyJson)
                    let resFetch = await fetch(url, options);
                    console.log(await resFetch.json())
                } else if (soil_humidity > (resUser.min_soil_humidity + 1) && soil_humidity < resUser.max_soil_humidity) {
                    await this.repo.changeNotifStatus("notif_soil_humidity", 0, userInfos.id);
                }
                if (temperature >= resUser.max_temperature && resUser.notif_temperature == 0) {
                    await this.repo.changeNotifStatus("notif_temperature", 1, userInfos.id);
                    bodyJson.template_id = '157bdcce-6a68-45a5-b41c-9743a3a9ebe1';
                    options.body = JSON.stringify(bodyJson)
                    let resFetch = await fetch(url, options);
                    console.log(await resFetch.json())
                } else if (temperature < (resUser.max_temperature - 1) && temperature > resUser.min_temperature) {
                    await this.repo.changeNotifStatus("notif_temperature", 0, userInfos.id);
                }
                if (temperature <= resUser.min_temperature && resUser.notif_temperature == 0) {
                    await this.repo.changeNotifStatus("notif_temperature", 1, userInfos.id);
                    bodyJson.template_id = '5da04335-5c30-442e-8edb-31e8748f76e9';
                    options.body = JSON.stringify(bodyJson)
                    let resFetch = await fetch(url, options);
                    console.log(await resFetch.json())
                } else if (temperature > (resUser.min_temperature + 1) && temperature < resUser.max_temperature) {
                    await this.repo.changeNotifStatus("notif_temperature", 0, userInfos.id);
                }
            }
            return true
        } catch (error) {
            console.log("error at @saveGreenhouseDataService : " + error)
            return { error: "Une erreur est survenue durant la sauvegarde des informations de la serre" }
        }
    }

    async addGreenhouseService(body, userInfos) {
        try {
            let greenhouse_name = body.greenhouse_name;
            if (greenhouse_name && greenhouse_name.length > 0) {
                if (greenhouse_name.length > 255) return { error: "Nom trop long" }
                let resDb = await this.repo.addGreenhouseRepo(greenhouse_name, userInfos.id);
                if (resDb[0].id) {
                    return resDb[0].id
                }
                else {
                    console.log("error at @addGreenhouseService : " + resDb)
                    return { error: "Une erreur est survenue durant l'ajout de la serre" }
                }
            } else return { error: "Body incomplet" }
        } catch (error) {
            console.log("error at @addGreenhouseService : " + error)
            return { error: "Une erreur est survenue durant l'ajout de la serre" }
        }
    }
    async getMyGreenhousesService(userInfos) {
        try {
            let userId = userInfos.id;
            let resDb = await this.repo.getMyGreenhousesRepo(userId);
            return resDb
        } catch (error) {
            console.log("error at @getMyGreenhousesService : " + error)
            return { error: "Une erreur est survenue durant la récupération des serres de la serre" }
        }
    }
}

module.exports = Greenhouseservice
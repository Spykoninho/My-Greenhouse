const raspInfoService = require('../service/raspInfoService');

class RaspInfoController{
    service;
    constructor(){
        this.service = new raspInfoService()
    }

    saveGreenhouseData = async (req, res) => {
        try {
            let resService = await this.service.saveGreenhouseDataService(req.body, req.user)
            if(resService.error) res.status(400).json({error: resService.error})
            else res.status(200).json({message: "Données envoyées !"})
        } catch (error) {
            console.log("error at @saveGreenhouseData : " + error)
            res.status(500).json({error: "Une erreur est survenue durant l'envoi des informations à la serre"})
        }
    }
}

module.exports = RaspInfoController
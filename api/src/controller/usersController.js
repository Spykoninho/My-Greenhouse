const UsersService = require('../service/usersServices');


class UsersController {
    service;
    constructor() {
        this.service = new UsersService()
    }

    getMyInfos = async (req, res) => {
        try {
            let resService = await this.service.getMyInfosService(req.user.id)
            if (resService.error) res.status(400).json({ error: "Une erreur est survenue durant la récupération des informations." })
            else res.status(200).json({ userInfos: resService })
        } catch (error) {
            console.log("error at @getMyInfos : " + error)
            res.status(500).json({ error: "Une erreur est survenue durant la récupération des informations." })
        }
    }

    signIn = async (req, res) => {
        try {
            let resService = await this.service.signInService(req.body)
            if (resService.error) res.status(400).json({ error: resService.error })
            else {
                res.cookie('MyGreenhouseCookie', resService.jwt, {
                    domain: process.env.URL_SITE,
                    path: '/',
                    secure: true,
                    expires: new Date(Date.now() + (1000 * 3600) * 24 * 30), // 1 mois
                    httpOnly: false,
                    credentials: 'include'
                })
                res.status(200).json({ message: "Inscription réussie !", jwt: resService.jwt })
            }
        } catch (error) {
            console.log("error at @signIn : " + error)
            res.status(500).json({ error: "Une erreur est survenue durant l'inscription" })
        }
    }

    logIn = async (req, res) => {
        try {
            let resService = await this.service.logInService(req.body)
            if (resService.error) res.status(400).json({ error: resService.error })
            else {
                res.cookie('MyGreenhouseCookie', resService.jwt, {
                    domain: process.env.URL_SITE,
                    path: '/',
                    secure: true,
                    expires: new Date(Date.now() + (1000 * 3600) * 24 * 30), // 1 mois
                    httpOnly: false,
                    credentials: 'include'
                })
                res.status(200).json({ message: "Connexion réussie !", jwt: resService.jwt })
            }
        } catch (error) {
            console.log("error at @logIn : " + error)
            res.status(500).json({ error: "Une erreur est survenue durant l'inscription" })
        }
    }
    setOneSignalId = async (req, res) => {
        try {
            let oneSignalId = req.body.onesignal_id
            let resService = await this.service.setOneSignalIdService(oneSignalId, req.user);
            if (resService.error) res.status(400).json({ error: resService.error })
            else
                res.status(200).json({ message: "Id ajouté avec succès !" })
        } catch (error) {
            console.log("error at @setOneSignalId : " + error)
            res.status(500).json({ error: "Une erreur est survenue durant l'ajout de l'id" })
        }
    }
}

module.exports = UsersController
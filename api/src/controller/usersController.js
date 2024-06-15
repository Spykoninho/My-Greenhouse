const UsersService = require('../service/usersServices');


class UsersController{
    service;
    constructor(){
        this.service = new UsersService()
    }

    signIn = async (req, res) => {
        try {
            let resService = await this.service.signInService(req.body)
            if(resService.error) res.status(400).json({error: resService.error})
            else{
                res.cookie('MyGreenhouseCookie', resService.jwt, { 
                    domain: process.env.URL_SITE,
                    path: '/',
                    secure: false,
                    expires: new Date(Date.now()+(1000 * 3600)*24*30), // 1 mois
                    httpOnly: false,
                    credentials: 'include'
                })
                res.status(200).json({message: "Inscription réussie !"})
            } 
        } catch (error) {
            console.log("error at @signIn : " + error)
            res.status(500).json({error: "Une erreur est survenue durant l'inscription"})
        }
    }

    logIn = async (req, res) =>{
        try {
            let resService = await this.service.logInService(req.body)
            if(resService.error) res.status(400).json({error: resService.error})
            else{
                res.cookie('MyGreenhouseCookie', resService.jwt, { 
                    domain: process.env.URL_SITE,
                    path: '/',
                    secure: false,
                    expires: new Date(Date.now()+(1000 * 3600)*24*30), // 1 mois
                    httpOnly: false,
                    credentials: 'include'
                })
                res.status(200).json({message: "Connexion réussie !"})
            } 
        } catch (error) {
            console.log("error at @logIn : " + error)
            res.status(500).json({error: "Une erreur est survenue durant l'inscription"})
        }
    }
}

module.exports = UsersController
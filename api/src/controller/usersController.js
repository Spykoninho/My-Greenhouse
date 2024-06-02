const UsersService = require('../service/usersServices');

class UsersController{
    service;
    constructor(){
        this.service = new UsersService()
    }

    signIn = async (req, res) => {
        try {
            let resService = await this.service.signInService(req.body)
            console.log(resService)
            res.status(200).json({message: "Inscription réussie !", jwt: "jwt", id: 1})
        } catch (error) {
            console.log("error at @signIn : " + error)
            res.status(500).json({error: "Une erreur est survenue durant l'inscription"})
        }
    }
}

module.exports = UsersController
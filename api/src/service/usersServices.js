var jsonwebtoken = require('jsonwebtoken');
const usersRepo = require('../repository/usersRepo')
const utilService = require('./utilService')
class UsersService{
    repo;
    util;
    constructor(){
        this.repo = new usersRepo();
        this.util = new utilService();
    }
    
    async signInService(body){
        try {
            if(!body.email || !body.password || !body.username || !body.newsletter || !body.postal_code) return {error: "Body incomplet"}
            if(!this.util.checkEmail(body.email) || body.username.length>255 || !this.util.checkNewsletter(body.newsletter) || !this.util.checkPostalCode(body.postal_code)) return {error: "Données invalides"}
            if(!this.util.checkPwd(body.password)) return {error: "Mot de passe trop faible"}
            let salt = this.util.createSalt()
            let hashedPwd = this.util.hashPwd(body.password, salt)
            let inseeCode = await this.util.getInseeByPostal(body.postal_code)
            let resDb = await this.repo.signInRepo(body.email, hashedPwd, body.username, body.newsletter, salt, inseeCode)
            if(resDb && resDb[0] && resDb[0].id) return {id: resDb[0].id, jwt: jsonwebtoken.sign({id: resDb[0].id, email: resDb[0].email, username: resDb[0].username}, process.env.SECRET_JWT, {expiresIn: '30d'})}
            else return {error: "Erreur, identifiant déjà utilisé"}
        } catch (error) {
            console.log(error)
            return {error: "Une erreur est survenue durant l'inscription"}
        }
    }

    async logInService(body){
        try {
            if(!body.username || !body.password ) return {error: "Body incomplet"}
            let salt = await this.repo.getUserByLogin(body.username)
            if(salt && salt[0] && salt[0].salt) salt=salt[0].salt
            else return {error: "Login incorrect"}
            let hashedPwd = this.util.hashPwd(body.password, salt)
            let resDb = await this.repo.logInRepo(body.username, hashedPwd)
            if(resDb && resDb[0] && resDb[0].id) return {id: resDb[0].id, jwt: jsonwebtoken.sign({id: resDb[0].id, email: resDb[0].email, username: resDb[0].username}, process.env.SECRET_JWT, {expiresIn: '30d'})}
            else return {error: "Login incorrect"}
        } catch (error) {
            console.log(error)
            return {error: "Une erreur est survenue durant la connexion"}
        }
    }
}

module.exports = UsersService
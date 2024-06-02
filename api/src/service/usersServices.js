const usersRepo = require('../repository/usersRepo')
class UsersService{
    repo;
    constructor(){
        this.repo = new usersRepo();
    }
    
    async signInService(body){
        try {
            let resDb = await this.repo.signInRepo(body.email, body.password, body.username, body.newsletter)
            return resDb
        } catch (error) {
            console.log(error)
        }
    }
}

module.exports = UsersService
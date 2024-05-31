const usersRepo = require('../repository/usersRepo')
class UsersService{
    repo;
    constructor(){
        this.repo = new usersRepo();
    }
}

module.exports = UsersService
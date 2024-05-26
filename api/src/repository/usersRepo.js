const dbConnection = require('./db')
class UsersRepo{
    db;
    constructor(){
        this.db = dbConnection
    }
}

module.exports = UsersRepo
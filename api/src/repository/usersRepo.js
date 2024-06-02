const dbConnection = require('./db')
class UsersRepo{
    db;
    constructor(){
        this.db = dbConnection
    }

    async signInRepo(email, password, username, newsletter){
        const sqlQuery = "INSERT INTO user (email, password, username, newsletter) VALUES (?, ?, ?, ?) RETURNING id";
        await this.db.query(sqlQuery, [email, password, username, newsletter], (err, result) => {
            if(err) throw err
            console.log(result)
            return result
        })
    }
}

module.exports = UsersRepo
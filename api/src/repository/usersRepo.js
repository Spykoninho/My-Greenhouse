const dbConnection = require('./db')

class UsersRepo{
    db;
    constructor(){
        this.db = dbConnection
    }

    async executeQuery(query, params) {
        let connection;
        try {
            connection = await this.db.getConnection();
            const rows = await connection.query(query, params)
            return rows
        } catch (error) {
            throw error
        }finally{
            if(connection) connection.release();
        }
    }

    async signInRepo(email, password, username, newsletter, salt, insee_code){
        const sqlQuery = "INSERT INTO user (email, password, username, newsletter, salt, insee_code) VALUES (?, ?, ?, ?, ?, ?) RETURNING id, email, username";
        let resDb = await this.executeQuery(sqlQuery, [email, password, username, newsletter, salt, insee_code])
        return resDb
    }
}

module.exports = UsersRepo
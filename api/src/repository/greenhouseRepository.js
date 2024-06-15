const dbConnection = require('./db')

class GreenhouseRepository{
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

    async saveGreenhouseDataRepo(){
        const sqlQuery = "INSERT INTO log_greenhouse (greenhouse_id_fk, humidity, soil_humidity, temperature) VALUES (?, ?, ?, ?)"
        const params = [1, 0, 0, 0]
        let resDb = await this.executeQuery(sqlQuery, params)
        return resDb
    }

}

module.exports = GreenhouseRepository
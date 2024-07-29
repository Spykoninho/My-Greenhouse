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

    async saveGreenhouseDataRepo(idGreenhouse, humidity, soil_humidity, temperature, feel_temperature, datetime){
        const sqlQuery = "INSERT INTO log_greenhouse (greenhouse_id_fk, humidity, soil_humidity, temperature, feel_temperature, date) VALUES (?, ?, ?, ?, ?, ?)"
        const params = [idGreenhouse, humidity, soil_humidity, temperature, feel_temperature, datetime]
        let resDb = await this.executeQuery(sqlQuery, params)
        return resDb
    }

    async addGreenhouseRepo(greenhouse_name, userId){
        const sqlQuery = "INSERT INTO greenhouse (user_id_fk, name) VALUES (?, ?) RETURNING id"
        const params = [userId, greenhouse_name]
        let resDb = await this.executeQuery(sqlQuery, params)
        return resDb
    }

}

module.exports = GreenhouseRepository
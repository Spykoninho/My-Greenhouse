const dbConnection = require('./db')

class GreenhouseRepository {
    db;
    constructor() {
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
        } finally {
            if (connection) connection.release();
        }
    }

    async saveGreenhouseDataRepo(idGreenhouse, humidity, soil_humidity, temperature, feel_temperature, datetime) {
        const sqlQuery = "INSERT INTO log_greenhouse (greenhouse_id_fk, humidity, soil_humidity, temperature, feel_temperature, date) VALUES (?, ?, ?, ?, ?, ?)"
        const params = [idGreenhouse, humidity, soil_humidity, temperature, feel_temperature, datetime]
        let resDb = await this.executeQuery(sqlQuery, params)
        return resDb
    }

    async addGreenhouseRepo(greenhouse_name, userId) {
        const sqlQuery = "INSERT INTO greenhouse (user_id_fk, name) VALUES (?, ?) RETURNING id"
        const params = [userId, greenhouse_name]
        let resDb = await this.executeQuery(sqlQuery, params)
        return resDb
    }

    async getMyGreenhousesRepo(userId) {
        const sqlQuery = "SELECT g.name AS greenhouse_name, lg.humidity, lg.soil_humidity, lg.temperature, lg.feel_temperature, DATE_FORMAT(lg.date,'%d/%m/%Y %H:%i:%s')AS last_update, lg.id FROM greenhouse AS g LEFT JOIN log_greenhouse AS lg ON lg.id = (SELECT id FROM log_greenhouse WHERE greenhouse_id_fk = g.id ORDER BY date DESC LIMIT 1) WHERE g.user_id_fk = ?"
        const params = [userId]
        let resDb = await this.executeQuery(sqlQuery, params)
        return resDb
    }

    async changeNotifStatus(notif_type, status, userId) {
        let sqlQuery;
        if (notif_type == "notif_temperature") {
            sqlQuery = "UPDATE user SET notif_temperature = ? WHERE id = ?";
        } else if (notif_type == "notif_soil_humidity") {
            sqlQuery = "UPDATE user SET notif_soil_humidity = ? WHERE id = ?";
        } else {
            sqlQuery = "UPDATE user SET notif_air_humidity = ? WHERE id = ?";
        }
        const params = [status, userId]
        console.log(sqlQuery, status)
        let resDb = await this.executeQuery(sqlQuery, params)
        return resDb
    }

}

module.exports = GreenhouseRepository
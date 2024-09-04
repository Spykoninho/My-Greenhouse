const dbConnection = require('./db')

class UsersRepo {
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
            console.log(error)
            return false
        } finally {
            if (connection) connection.release();
        }
    }

    async getMyInfosRepo(userId) {
        const sqlQuery = "SELECT id, email, username, newsletter, darkmode, language, min_soil_humidity, max_soil_humidity, min_air_humidity, max_air_humidity, min_temperature, max_temperature, notifications, notif_temperature, notif_air_humidity, notif_soil_humidity, onesignal_id, rank, insee_code FROM user WHERE id = ?";
        let resDb = await this.executeQuery(sqlQuery, [userId])
        return resDb
    }

    async signInRepo(email, password, username, newsletter, salt, insee_code) {
        const sqlQuery = "INSERT INTO user (email, password, username, newsletter, salt, insee_code) VALUES (?, ?, ?, ?, ?, ?) RETURNING id, email, username";
        let resDb = await this.executeQuery(sqlQuery, [email, password, username, newsletter, salt, insee_code])
        return resDb
    }

    async logInRepo(username, password) {
        const sqlQuery = "SELECT id, email, username FROM user WHERE (email = ? OR username = ?) AND password = ?";
        let resDb = await this.executeQuery(sqlQuery, [username, username, password])
        return resDb
    }

    async getUserByLogin(login) {
        const sqlQuery = "SELECT * FROM user WHERE email = ? OR username = ?";
        let resDb = await this.executeQuery(sqlQuery, [login, login])
        return resDb
    }

    async setOneSignalIdRepo(oneSignalId, userId) {
        const sqlQuery = "UPDATE user set onesignal_id = ? WHERE id = ?";
        let resDb = await this.executeQuery(sqlQuery, [oneSignalId, userId])
        return resDb
    }
}

module.exports = UsersRepo
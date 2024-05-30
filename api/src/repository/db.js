var mysql = require('mysql2');
var connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_USER_PWD,
    database: process.env.DB_DATABASE,
    port: process.env.DB_PORT
});

module.exports = connection
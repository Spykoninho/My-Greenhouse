const mariadb = require('mariadb');

var connection = mariadb.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_USER_PWD,
    database: process.env.DB_DATABASE,
    port: process.env.DB_PORT,
    connectionLimit: 5
});

module.exports = connection
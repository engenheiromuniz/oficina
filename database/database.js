const Sequelize = require("sequelize");
const connection = new Sequelize('bco_oficina','root','root',{
    host: 'localhost',
    dialect: 'mysql'
});

module.exports = connection;

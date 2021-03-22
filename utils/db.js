const mysql = require('mysql');
const util = require('util'); //thu vien nodejs

const pool = mysql.createPool({
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: '17092000',
  database: 'bakery',
  connectionLimit: 50,
  insecureAuth : true
});

const pool_query = util.promisify(pool.query).bind(pool);``

module.exports = {
  load: sql => pool_query(sql),
  add: (entity, tableName) => pool_query(`insert into ${tableName} set ?`, entity),
  del: (condition, tableName, condition2={1:1}) => pool_query(`delete from ${tableName} where ? and ?`, [condition, condition2]),
  patch: (entity, condition, tableName, condition2={1:1}) => pool_query(`update ${tableName} set ? where ? AND ?`, [entity, condition, condition2])
};

const db = require('../utils/db');

const TBL_USERS = 'client';

module.exports = {
  all() {
    return db.load(`select * from ${TBL_USERS}`);
  },
  async singleByUserName(username) {
    const rows = await db.load(`select * from ${TBL_USERS} where username = '${username}'`);
    if (rows.length === 0)
      return null;

    return rows[0];
  },
  add(entity) {
    return db.add(entity, TBL_USERS);
  },
  patch(entity) {
    const condition = { clientID: entity.clientID };
    delete entity.clientID;
    return db.patch(entity, condition, TBL_USERS);
  },
  del(entity) {
    const condition = { clientID: entity.clientID };
    return db.del(condition, TBL_USERS);
  },
};

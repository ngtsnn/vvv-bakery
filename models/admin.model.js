const db = require('../utils/db');

const TBL_USERS = 'admin';

module.exports = {
  all() {
    return db.load(`select * from ${TBL_USERS}`);
  },
  async singleByUserName(username) {
    const rows = await db.load(`select * from ${TBL_USERS} where adminName = '${username}'`);
    if (rows.length === 0)
      return null;

    return rows[0];
  },
  add(entity) {
    const newEntity = {cookingType: entity.cookingType}
    return db.add(newEntity, TBL_USERS);
  },
  patch(entity) {
    const condition = { adminID: entity.adminID };
    delete entity.adminID;
    return db.patch(entity, condition, TBL_USERS);
  },
  del(entity) {
    const condition = { cookingTypeID: entity.cookingTypeID };
    return db.del(condition, TBL_USERS);
  },
};

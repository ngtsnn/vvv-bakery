const db = require('../utils/db');

const TBL_COOKING_TYPE = 'cooking_type';

module.exports = {
  all() {
    return db.load(`select * from ${TBL_COOKING_TYPE}`);
  },
  add(entity) {
    const newEntity = {cookingType: entity.cookingType}
    return db.add(newEntity, TBL_COOKING_TYPE);
  },
  patch(entity) {
    const condition = { cookingTypeID: entity.cookingTypeID };
    delete entity.cookingTypeID;
    return db.patch(entity, condition, TBL_COOKING_TYPE);
  },
  del(entity) {
    const condition = { cookingTypeID: entity.cookingTypeID };
    return db.del(condition, TBL_COOKING_TYPE);
  },
};

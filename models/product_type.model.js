const db = require('../utils/db');

const TBL_PRODUCT_TYPE = 'product_type';

module.exports = {
  all() {
    return db.load(`select * from ${TBL_PRODUCT_TYPE}`);
  },

  // allWithDetails() {
  //   const sql = `
  //     select c.*, count(p.ProductID) as ProductCount
  //     from categories c left join products p on c.productID = p.productID
  //     group by c.productID, c.productName
  //   `;
  //   return db.load(sql);
  // },

  // async single(id) {
  //   const rows = await db.load(`select * from ${TBL_PRODUCT_TYPE} where productID = ${id}`);
  //   if (rows.length === 0)
  //     return null;

  //   return rows[0];
  // },

  add(entity) {
    const newEntity = {
      productType: entity.productType,
      mainType: entity.mainType,
      subType: entity.subType
    }
    return db.add(newEntity, TBL_PRODUCT_TYPE);
  },
  patch(entity) {
    const condition = { productTypeID: entity.productTypeID };
    delete entity.productTypeID;
    return db.patch(entity, condition, TBL_PRODUCT_TYPE);
  },
  del(entity) {
    const condition = { productTypeID: entity.productTypeID };
    return db.del(condition, TBL_PRODUCT_TYPE);
  },
  // add(entity) {
  //   return db.add(entity, TBL_PRODUCT_TYPE)
  // },

};

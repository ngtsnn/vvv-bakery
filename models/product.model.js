const db = require('../utils/db');
const TBL_PRODUCT = 'product';

module.exports = {
  all() {
    return db.load(`select * from bakery.product as PR 
		left join bakery.cooking_type as CT on PR.cookingTypeID = CT.cookingTypeID 
        left join bakery.product_type as PT on PR.productTypeID = PT.productTypeID`);
  },
  async singleByID(id) {
    const data = await db.load(`select * from bakery.product as PR 
		left join bakery.cooking_type as CT on PR.cookingTypeID = CT.cookingTypeID 
        left join bakery.product_type as PT on PR.productTypeID = PT.productTypeID
        where PR.productID = ${id}`);
    return data[0];
  },
  searchByProductType(id) {
    return db.load(`select * from bakery.product as PR 
		left join bakery.cooking_type as CT on PR.cookingTypeID = CT.cookingTypeID 
    left join bakery.product_type as PT on PR.productTypeID = PT.productTypeID
    where PT.productTypeID = ${id}`);
  },
  searchByCookingType(id) {
    return db.load(`select * from bakery.product as PR 
		left join bakery.cooking_type as CT on PR.cookingTypeID = CT.cookingTypeID 
    left join bakery.product_type as PT on PR.productTypeID = PT.productTypeID
    where CT.cookingTypeID = ${id}`);
  },
  searchByProductName(name) {
    return db.load(`select * from bakery.product as PR 
		left join bakery.cooking_type as CT on PR.cookingTypeID = CT.cookingTypeID 
    left join bakery.product_type as PT on PR.productTypeID = PT.productTypeID`);
  },
  add(entity) {
    const newEntity = {
      productName: entity.productName,
      unitPrice: entity.unitPrice,
      unit: entity.unit,
      description: entity.description,
      productTypeID: entity.productTypeID,
      cookingTypeID: entity.cookingTypeID,
      origin: entity.origin
    }
    return db.add(newEntity, TBL_PRODUCT);
  },
  patch(entity) {
    const condition = { productID: entity.productID };
    delete entity.productID;
    return db.patch(entity, condition, TBL_PRODUCT);
  },
  del(entity) {
    const condition = { productID: entity.productID };
    return db.del(condition, TBL_PRODUCT);
  },
};

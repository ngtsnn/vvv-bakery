const db = require('../utils/db');

const TBL_CART_DETAIL = 'cart_detail';

module.exports = {
  all() {
    return db.load(`select * from ${TBL_CART_DETAIL}`);
  },
  getByClientID(ID) {
    return db.load(`SELECT * FROM ${TBL_CART_DETAIL} as CD left join bakery.product as PR on CD.productID = PR.productID where CD.clientID = ${ID} `)
  },
  async getTotal(ID) {
    const data = await db.load(`SELECT sum(CD.quantity) as sum FROM bakery.cart_detail as CD where CD.clientID = ${ID}`)
    return data[0].sum;
  },
  async checkProductHas(clientID, productID) {
    const data = await db.load(`SELECT * FROM ${TBL_CART_DETAIL} as CD where CD.clientID = ${clientID} and CD.productID = ${productID}`)
    if (data.length === 0)
      return null;

    return data[0];
  },
  async update(entity) {
    const checkProductHas = await this.checkProductHas(entity.clientID, entity.productID);
    if (entity.quantity == undefined) {
      entity.quantity = 1;
    }
    if (checkProductHas) {
      const condition = { clientID: entity.clientID};
      const condition2 = { productID: entity.productID }
      delete entity.cookingTypeID;
      delete entity.productID;
      return db.patch(entity, condition, TBL_CART_DETAIL, condition2);
    }
    
    return await db.add(entity, TBL_CART_DETAIL);
  },
  del(entity) {
    const condition = { clientID: entity.clientID};
    const condition2 = { productID: entity.productID }
    return db.del(condition, TBL_CART_DETAIL, condition2);
  },
};

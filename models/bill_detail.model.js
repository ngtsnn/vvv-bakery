const db = require('../utils/db');

const TBL_BILL_DETAIL = 'bill_detail';

module.exports = {
  all() {
    return db.load(`select * from ${TBL_CATEGORIES}`);
  },

  allWithDetails() {
    const sql = `
      select c.*, count(p.ProID) as ProductCount
      from categories c left join products p on c.CatID = p.CatID
      group by c.CatID, c.CatName
    `;
    return db.load(sql);
  },

  getByClientID(ID) {
    return db.load(`SELECT * FROM bakery.bill as B join bakery.bill_detail as BD on B.billID = BD.billID where B.clientID = ${ID} `)
  },

  async single(id) {
    const rows = await db.load(`select * from ${TBL_CATEGORIES} where CatID = ${id}`);
    if (rows.length === 0)
      return null;

    return rows[0];
  },
  

  add(entity) {
    return db.add(entity, TBL_CATEGORIES)
  },

  del(entity) {
    const condition = { CatID: entity.CatID };
    return db.del(condition, TBL_CATEGORIES);
  },

  patch(entity) {
    const condition = { CatID: entity.CatID };
    delete entity.CatID;
    return db.patch(entity, condition, TBL_CATEGORIES);
  }
};

const express = require("express");

const productTypeModel = require('../models/product_type.model');
const cookingTypeModel = require('../models/cooking_type.model');
const productModel = require('../models/product.model');
const clientModel = require('../models/client.model');
const cartDetailModel = require('../models/cart_detail.model');
const billDetailModel = require('../models/bill_detail.model');

const router = express.Router();

function auth(req, res, next) {
  if (req.session.isAuth === false) {
    return res.redirect('/');
  }
  next();
}

router.get("/", async function (req, res) {
  const product_type_Arr = await productTypeModel.all();

  const product_Arr_1 = await productModel.searchByProductType(product_type_Arr[0].productTypeID);
  const product_Arr_2 = await productModel.searchByProductType(product_type_Arr[1].productTypeID);

  return res.render('site/index.hbs', {
    title: "Home",
    product_Arr_1_name: product_type_Arr[0].productType, 
    product_Arr_1: product_Arr_1,
    product_Arr_2_name: product_type_Arr[1].productType, 
    product_Arr_2: product_Arr_2
  })
});
router.get("/search", async function(req, res, next) {
  let product_type_Arr = await productTypeModel.all();
  let product_Arr = [];
  let product_type = -1;

  if (req.query['product-type'] !== undefined ) {
    product_Arr = await productModel.searchByProductType(req.query['product-type'])
    product_type = req.query['product-type']
  }
  if (req.query['cooking-type'] !== undefined ) {
    product_Arr = await productModel.searchByCookingType(req.query['cooking-type'])
  }
  if (req.query['product'] !== undefined ) {
    product_Arr = await productModel.searchByProductName(req.query['product'])
  }
  return res.render('site/products.hbs',{
    title: "Search",
    product_type: product_type,
    product_type_Arr : product_type_Arr,
    product_Arr: product_Arr
  })
})
router.get('/product/:id', async function(req, res, next) {
  const productItem = await productModel.singleByID(req.params.id);
  return res.render('site/product', {
    title: 'Product',
    product: productItem
  })
})


router.get('/get/product-type',async function(req, res) {
  const cooking_type_Arr = await productTypeModel.all();
  return res.json({
    total: cooking_type_Arr.length,
    data: cooking_type_Arr
  })
})
router.get('/get/cooking-type',async function(req, res) {
    const cooking_type_Arr = await cookingTypeModel.all();
    return res.json({
      total: cooking_type_Arr.length,
      data: cooking_type_Arr
    })
})

router.get("/cart", auth, async function(req, res, next){
  const clientID = req.session.authUser.clientID;
  const cart_detail_arr = await cartDetailModel.getByClientID(clientID);

  return res.render("site/cart", {
    title: 'Cart',
    isEmpty: cart_detail_arr.length == 0,
    cart_detail_arr : cart_detail_arr
  })
})
router.get("/cart/total", auth, async function(req, res, next){
  const clientID = req.session.authUser.clientID;
  const total = await cartDetailModel.getTotal(clientID);
  return res.json(total)
})

router.post("/cart", auth, async function(req, res, next){
  console.log(req.body);
  const clientID = req.session.authUser.clientID;
  const cart_detail = await cartDetailModel.update({...req.body, clientID});
  return res.json({
    status: true,
    data: cart_detail
  });
})
router.post("/cart/tocheckout", auth, async function(req, res, next){
  console.log(req.body);
  // const clientID = req.session.authUser.clientID;
  // const cart_detail = await cartDetailModel.update({...req.body, clientID});
  req.session.checkout = req.body.data;
  return res.json(true);
})
router.delete("/cart", auth, async function(req, res, next){
  console.log(req.body);
  const clientID = req.session.authUser.clientID;
  const cart_detail = await cartDetailModel.del({...req.body, clientID});
  return res.json({
    status: true,
    data: cart_detail
  });
})

router.get('/checkout', auth, async function(req, res, next) {
  const checkout_arr = req.session.checkout
  let totalMoney = checkout_arr.reduce(function (total, currentValue) {
    return total + currentValue.productPrice * currentValue.quantity;
    }, 0);
  return res.render('site/checkout', {
    title: "Checkout", 
    checkout_arr: checkout_arr,
    totalMoney: totalMoney
  })
})
router.post('/checkout', auth, async function(req, res, next) {
  console.log(req.body);
  
  // await billDetailModel.add();
  const checkout_arr = req.session.checkout;

  for (var i=0; i <checkout_arr.length; i++) {
    console.log("test")
    console.log({...checkout_arr[i], clientID: req.session.authUser.clientID})
    await cartDetailModel.del({...checkout_arr[i], clientID: req.session.authUser.clientID})
  }

  req.session.checkout = null;
  return res.redirect('/');
})

router.get('/user', auth, async function(req, res, next) {
  return res.send("This url to show profile user ^^")
})

router.get('/history', auth, async function(req, res, next){
  return res.render('site/manage_history',{
    title: "History"
  })
})

router.post('/login', async function(req, res, next) {
  const user = await clientModel.singleByUserName(req.body.username);
  if (user === null) {
    return res.json(false)
  }

  if (req.body.password !== user.password) {
    return res.json(false);
  }
  req.session.isAuth = true;
  req.session.authUser = user;
  // req.session.cart = [];
  return res.json(true);
})
router.post('/register', async function(req, res, next) {

  await clientModel.add(req.body);
  return res.redirect('/');
})
router.get('/is-available', async function (req, res) {
  const username = req.query.user;
  const user = await clientModel.singleByUserName(username);
  if (user === null) {
    return res.json(true);
  }

  return res.json(false);
})
router.post('/logout', async function (req, res) {
  req.session.isAuth = false;
  req.session.authUser = null;
  res.redirect('/');
})

router.get('/about', function(req, res) {
  return res.send("You can contact me with my phone - 090501590")
})
module.exports = router;

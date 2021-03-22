const express = require("express");
const multer = require('multer');

const productModel = require('../models/product.model');
const product_type = require('../models/product_type.model');
const cooking_type = require('../models/cooking_type.model');
const adminModel = require('../models/admin.model');

const router = express.Router();

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './public/images/')
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + file.originalname)
  }
});
const upload = multer({ storage });

router.get("/login.html", function (req, res) {
  if (req.headers.referer) {
    req.session.retUrl = req.headers.referer;
  }

  res.render("admin/login", {
    layout: false,
  });
});
router.post('/login.html', async function (req, res) {
  const user = await adminModel.singleByUserName(req.body.username);
  if (user === null) {
    return res.render('admin/login', {
      layout: false,
      err_message: 'Invalid username or password.'
    });
  }

  if (req.body.password !== user.adminPassword) {
    return res.render('admin/login', {
      layout: false,
      err_message: 'Invalid username or password.'
    });
  }

  req.session.isAuth = true;
  req.session.authUser = user;
  res.cookie('username', user.adminName);
  res.cookie('adminID', user.adminID);
  // req.session.cart = [];

  let url = req.session.retUrl || '/admin/dashboard.html';
  return res.redirect(url);
})

router.use(function (req, res, next) {
    if (req.session.isAuth === false) {
      req.session.retUrl = req.originalUrl;
      return res.redirect('/admin/login.html');
    }
    next();
  }
)

router.post('/logout', async function (req, res) {
  req.session.isAuth = false;
  req.session.authUser = null;
  req.session.cart = [];
  res.redirect(req.headers.referer);
})

router.get("/dashboard.html", function (req, res) {
  return res.render("admin/dashboard", {
    layout: "adminlayout",
    page: "thongke",
  });
});

router.get("/products.html", async function (req, res) {
  const products = await productModel.all();

  res.render("admin/products", {
     layout: "adminlayout",
     page: "sanpham",
     products: products,
   });
});
router.delete("/products.html", async function (req, res) {
  await productModel.del({productID: parseInt(req.body.id)})
  return res.send({mesage: 'success'});
});

router.get("/product.html", async function (req, res) {
  const cookingTypeArr = await cooking_type.all();
  const productTypeArr = await product_type.all();

  return res.render("admin/product", {
    layout: "adminlayout",
    page: "sanpham",
    cookingTypes: cookingTypeArr,
    productTypes: productTypeArr
  });
});
router.post("/product.html", upload.single("productImage"), async function (req, res) {
  // add product-type to db
  
  if (req.body.productID == '-1') {
    await productModel.add({...req.body, origin: req.file.filename})
  } else { // edit cooking type
    await productModel.patch({...req.body, origin: req.file.filename})
  }
  res.redirect("/admin/products.html");

});

router.get("/categories.html", async function (req, res) {
  const catArr = await product_type.all();
  const cookingArr = await cooking_type.all();

  res.render("admin/categories", {
     layout: "adminlayout",
     page: "danhmuc",
     catArr: catArr,
     cookingArr : cookingArr,
   });
});
router.delete("/categories.html", async function (req, res) {
  // console.log(req.body);
  if (req.body.type == 'cooking-type') {
    await cooking_type.del({cookingTypeID: parseInt(req.body.id)})
  }
  if (req.body.type == 'product-type') {
    await product_type.del({productTypeID: parseInt(req.body.id)})
  }
  return res.send({mesage: 'success'});
});


router.get("/cooking-type.html", function (req, res) {
  res.render("admin/cooking-type", {
     layout: "adminlayout",
     page: "danhmuc",
   });
});
router.post("/cooking-type.html", async function (req, res) {
  // console.log(req.body)
  // add cooking-type to db
  if (req.body.cookingTypeID === '-1') {
    await cooking_type.add(req.body);
  } else { // edit cooking type
    await cooking_type.patch(req.body);
  }
})

router.get("/product-type.html", function (req, res) {
  res.render("admin/product-type", {
     layout: "adminlayout",
     page: "danhmuc",
   });
});
router.post("/product-type.html", async function (req, res) {
  // console.log(req.body)
  // add cooking-type to db
  if (req.body.productTypeID === '-1') {
    await product_type.add(req.body);
  } else { // edit cooking type
    await product_type.patch(req.body);
  }
  return res.redirect('/admin/categories.html');
});


router.get("/product-type-income.html", function (req, res) {
  res.render("admin/product-type-income", {
     layout: "adminlayout",
     page: "thongke",
   });
});

router.get("/setting.html", function (req, res) {
  res.render("admin/setting", {
     layout: "adminlayout",
     page: "caidat",
   });
});
router.post("/setting.html", async function (req, res) {
  // console.log(req.body)

  await adminModel.patch(req.body)
  return res.redirect('/admin');

});
router.get("/", function (req, res) {
  res.redirect('/admin/dashboard.html');
});
module.exports = router;

var path = require('path');
const express = require('express');
const exphbs = require('express-handlebars');
const session = require('express-session');
const hbs_sections = require('express-handlebars-sections');
const cookieParser = require('cookie-parser');
require('express-async-errors');

const adminRoute = require('./routes/admin.route');
const siteRoute = require("./routes/site.route");

const app = express();

app.use(express.urlencoded({
  extended: true
}));

app.engine('hbs', exphbs({
  defaultLayout: 'main.hbs',
  extname: '.hbs',
  helpers: {
    section: hbs_sections(),
    ifeq: function (a, b, options) {
      if (a == b) { return options.fn(this); }
      return options.inverse(this);
  }
  }
}));
app.set('view engine', 'hbs');
app.use(express.static(path.join(__dirname, 'public')));

app.use(cookieParser());
app.use(session({
  secret: 'SECRET_KEY',
  resave: false,
  saveUninitialized: true,
  // store: sessionStore,
  cookie: {
    // secure: true
  }
}));

app.use(async function (req, res, next) {
  if (typeof (req.session.isAuth) === 'undefined') {
    req.session.isAuth = false;
    req.session.cart = [];
  }

  res.locals.isAuth = req.session.isAuth;
  res.locals.authUser = req.session.authUser;
  // res.locals.cartSummary = cartModel.getNumberOfItems(req.session.cart)
  next();
})

// app.use(async function (req, res, next) {
//   const rows = await categoryModel.allWithDetails();
//   res.locals.lcCategories = rows;
//   next();
// })

app.use('/', siteRoute);
app.use('/admin', adminRoute);

 app.use(function (req, res) {
  res.render('404', {
    layout: false
  })
});

// default error handler
app.use(function (err, req, res, next) {
  console.error(err.stack);
  res.render('500', {
    layout: false
  })
})

const PORT = process.env.PORT || 8080;
app.listen(PORT, _ => {
  console.log(`app listening at http://localhost:${PORT}`);
});
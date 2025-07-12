// odoo_service.js
const Odoo = require('odoo-await'); // Using the new, working library
require('dotenv').config();

const odoo = new Odoo({
  baseUrl: process.env.ODOO_URL, // This library uses 'baseUrl'
  db: process.env.ODOO_DB,
  username: process.env.ODOO_USERNAME,
  password: process.env.ODOO_PASSWORD
});

module.exports = odoo;
require('coffee-script/register');
path = require('path');

// Since this is called from the html file,
// __dirname is not set.
require("./app/app.coffee");

require('coffee-script/register');
path = require('path');

// Since this is called from the html file,
// __dirname is set to the parent of this file's folder
require(path.join(__dirname, "app", "app.coffee"))

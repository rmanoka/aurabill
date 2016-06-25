nw.require('coffee-script/register');
path = nw.require('path');

// Since this is called from the html file,
// __dirname is not set.
nw.require("app/app.coffee");

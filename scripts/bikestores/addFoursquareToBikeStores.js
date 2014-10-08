var config = require('./config');
console.log(config.foursquare);

var foursquare = require('node-foursquare')(config.foursquare);

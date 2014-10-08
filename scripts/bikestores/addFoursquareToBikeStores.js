var fs = require('fs');
var file = JSON.parse(fs.readFileSync('stores_foursquare.json'));
var config = require('./config');

var accessToken = null;
var Foursquare = require('node-foursquare')(config.foursquare);

// bike shop 4bf58dd8d48988d115951735
// bike rental/bike share 4e4c9077bd41f78e849722f9

var matches = 0;

var Semaphore = {
  waiting: 0,
  finished: 0,
  inc: function() { this.waiting++; },
  done: function(cb) {
    this.finished++;
    if (this.waiting === this.finished) {
      console.log('Finished loading ')
      cb();
    }
  }
};

var matchId = function(idx, shop) {
  var params = {
    near: 'New York, NY',
    radius: 100000,
    limit: 1,
    query: shop.name,
    intent: 'browse',
  };
  Semaphore.inc();
  Foursquare.Venues.search(null, null, 'New York, NY', params, accessToken, function (error, data) {
    if(error) {
      console.error(error);
    }
    else {
      try {
        if (data.venues.length !== 0) {
          var fs_data = {
            id : data.venues[0].id,
            name : data.venues[0].name
          };
          if (!file[idx].foursquare) {
            file[idx].foursquare = fs_data;
            matches++;
          }
        }
        Semaphore.done(function() {
          console.log('Writing stores_foursquare_new.json');
          console.log('Matched ' + matches + ' out of ' + file.length + ' stores');
          fs.writeFileSync('stores_foursquare_new.json', JSON.stringify(file, undefined, 2));
        });
      } catch (error) {
        console.error(error);
      }
    }
  });
}

for (var i = 0; i<file.length; i++) {
  var shop = file[i];
  console.log('Loading data for:', shop.name);
  matchId(i, shop);
}


// id
// name
// contact.formattedPhone
// location.formattedAddress[0] + ', ' + location.formattedAddres[1]

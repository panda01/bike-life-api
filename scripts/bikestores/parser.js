var _ = require('underscore');
var fs = require('fs');
var parseString = require('xml2js').parseString;

var file = fs.readFileSync('shops.xml');
parseString(file, function (err, result) {
      var parsed = _.map(result.bikeshops.shop, function(pl) {
        var data = {
          name: pl.name[0],
          address: pl.address[0] + ', '+  pl.boro[0] + ', NY',
          boro: pl.boro[0],
          storetype: parseInt(pl.type[0]),
          hours: pl.hours[0],
          website: pl.website[0]
        };
        var geo = pl.wkt[0];
        var latlng = geo.split(' ');
        data.latitude = parseFloat(latlng[0]);
        data.longitude = parseFloat(latlng[1]);

        return data;
      });
      fs.writeFileSync('stores.json', JSON.stringify(parsed, undefined, 2));
});

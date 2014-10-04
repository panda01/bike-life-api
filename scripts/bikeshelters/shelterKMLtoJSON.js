var _ = require('underscore');
var fs = require('fs');
var parseString = require('xml2js').parseString;

var file = fs.readFileSync('bike_shelters.kml');
parseString(file, function (err, result) {
      var parsed = _.map(result.kml.Document[0].Placemark, function(pl) {
        var data = {
          name: pl.name[0],
          address: pl.name + ', NY',
        };
        var geo = pl.Point;
        if (pl.Point && pl.Point[0]) {
          var latlng = pl.Point[0].coordinates[0].split(',');
          data.geo = {
            lat: latlng[0],
            lng: latlng[1]
          };
        }
        return data;
      });
      fs.writeFileSync('shelters.json', JSON.stringify(parsed, undefined, 2));
});

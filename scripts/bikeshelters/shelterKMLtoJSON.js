var _ = require('underscore');
var fs = require('fs');
var parseString = require('xml2js').parseString;

var file = fs.readFileSync('bike_shelters.kml');
parseString(file, function (err, result) {
      var parsed = _.map(result.kml.Document[0].Placemark, function(pl) {
        var data = {
          name: pl.name[0],
          Address: pl.name + ', NY',
          isRack: false 
        };
        var geo = pl.Point;
        if (pl.Point && pl.Point[0]) {
          var latlng = pl.Point[0].coordinates[0].split(',');
          data.Lat = parseFloat(latlng[0]);
          data.Lng = parseFloat(latlng[1]);
        }
        return data;
      });
      fs.writeFileSync('shelters.json', JSON.stringify(parsed, undefined, 2));
});

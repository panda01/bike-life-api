var _ = require('underscore');
var fs = require('fs');
var parseString = require('xml2js').parseString;

var file = fs.readFileSync('2013-cityracks.kml');
parseString(file, function (err, result) {
      var parsed = _.map(result.kml.Document[0].Placemark, function(pl) {
        var data = {
          name: pl.name,
          address: pl.address,
          racks: pl.ExtendedData[0].Data[0].value
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
      fs.writeFileSync('cityracks_full.json', JSON.stringify(parsed, undefined, 2));
});

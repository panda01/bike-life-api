var _ = require('underscore');
var fs = require('fs');
var parseString = require('xml2js').parseString;

var file = fs.readFileSync('2013-cityracks.kml');
parseString(file, function (err, result) {
      var parsed = _.map(result.kml.Document[0].Placemark, function(pl) {
        var data = {
          name: pl.name[0],
          address: pl.address[0],
          isRack: true 
        };
        var geo = pl.Point;
        if (pl.Point && pl.Point[0]) {
          var latlng = pl.Point[0].coordinates[0].split(',');
          data.latitude = parseFloat(latlng[0]);
          data.longitude = parseFloat(latlng[1]);
        }
        var racks = pl.ExtendedData[0].Data[0].value[0].split(' ');
        data.racks = parseInt(racks[0]);
        return data;
      });
      fs.writeFileSync('racks.json', JSON.stringify(parsed, undefined, 2));
});

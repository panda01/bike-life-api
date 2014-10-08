var fs = require('fs');
var file = JSON.parse(fs.readFileSync('stores_foursquare.json'));

for (var i = 0; i<file.length; i++) {
  if (file[i].foursquare) {
    file[i].foursquare_id = file[i].foursquare.id;
    file[i].foursquare_name = file[i].foursquare.name;
    delete file[i].foursquare;
  }
}

fs.writeFileSync('stores_foursquare_formatted.json', JSON.stringify(file, undefined, 2));
console.log('File Written.');

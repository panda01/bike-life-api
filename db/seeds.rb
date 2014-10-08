# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'


# ======== IMPORT FUNCTION ===========
def importFromFile(type, json_hash)
  idx = 0
  len = json_hash.length
  json_hash.each do |arr|
    type.create(arr)
    idx += 1
    puts "Added #{idx}/#{len}"
  end
end

# ======== IMPORT SHELTERS ===========
shelters_file = File.read('./scripts/bikeshelters/shelters.json')
shelters_hash = JSON.parse(shelters_file)
puts "Importing Shelters..."
importFromFile(Parking, shelters_hash)

# ======== IMPORT STORES ===========
puts "Importing Stores..."
stores_file = File.read('./scripts/bikestores/stores_foursquare_formatted.json')
stores_hash = JSON.parse(stores_file)
importFromFile(Store, stores_hash)

# ======== IMPORT RACKS ===========
puts "Importing Racks..."
racks_file = File.read('./scripts/bikeracks/racks.json')
racks_hash = JSON.parse(racks_file)
importFromFile(Parking, racks_hash)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'


# ======== IMPORT FUNCTION ===========
def importParking(json_hash)
  idx = 0
  len = json_hash.length
  json_hash.each do |arr|
    Parking.create(arr)
    idx += 1
    puts "Added #{idx}/#{len}"
  end
end

# ======== IMPORT SHELTERS ===========
shelters_file = File.read('./scripts/bikeshelters/shelters.json')
shelters_hash = JSON.parse(shelters_file)
puts "Importing Shelters..."
importParking(shelters_hash)

# ======== IMPORT RACKS ===========
puts "Importing Racks..."
racks_file = File.read('./scripts/bikeracks/racks.json')
racks_hash = JSON.parse(racks_file)
importParking(racks_hash)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'
racks_file = File.read('./scripts/bikeracks/racks.json')
racks_hash = JSON.parse(racks_file)
puts racks_hash[0]
racks_hash.each do |key, array|
  Parking.create(array)
end


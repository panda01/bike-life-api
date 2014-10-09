json.array!(@stores) do |store|
  json.extract! store, :id, :name, :address, :storetype, :hours, :website, :latitude, :longitude, :foursquare_id
end

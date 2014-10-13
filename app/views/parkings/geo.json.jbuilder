json.array!(@parkings) do |parking|
  json.extract! parking, :id, :name, :racks, :isRack
  json.url parking_url(parking, format: :json)
end

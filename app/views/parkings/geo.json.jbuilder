json.array!(@parkings) do |parking|
  json.extract! parking, :id, :name, :phone, :isRack, :hours
  json.url parking_url(parking, format: :json)
end

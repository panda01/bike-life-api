class RemoveLatLngFromParkings < ActiveRecord::Migration
  def change
    remove_column :parkings, :Lat, :float
    remove_column :parkings, :Lng, :float
  end
end

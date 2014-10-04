class AddLatLngToParkings < ActiveRecord::Migration
  def change
    add_column :parkings, :latitiude, :float
    add_index :parkings, :latitiude
    add_column :parkings, :latitude, :float
    add_index :parkings, :latitude
  end
end

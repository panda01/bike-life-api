class AddLngToParkings < ActiveRecord::Migration
  def change
    add_column :parkings, :longitude, :float
  end
end

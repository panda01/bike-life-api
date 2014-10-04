class AddLongToParkings < ActiveRecord::Migration
  def change
    add_column :parkings, :longitude, :float
    add_index :parkings, :longitude
  end
end

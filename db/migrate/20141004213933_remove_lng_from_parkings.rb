class RemoveLngFromParkings < ActiveRecord::Migration
  def change
    remove_column :parkings, :longitude, :float
  end
end

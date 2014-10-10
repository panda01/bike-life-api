class AddFoursquareIdToStores < ActiveRecord::Migration
  def change
    add_column :stores, :foursquare_id, :string
    add_index :stores, :foursquare_id, unique: true
  end
end

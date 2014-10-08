class AddFoursquareToStores < ActiveRecord::Migration
  def change
    add_column :stores, :foursquare_id, :string
    add_column :stores, :foursquare_name, :string
  end
end

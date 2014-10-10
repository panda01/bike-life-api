class RemoveFoursquareFromStores < ActiveRecord::Migration
  def change
    remove_column :stores, :foursquare_id, :string
  end
end

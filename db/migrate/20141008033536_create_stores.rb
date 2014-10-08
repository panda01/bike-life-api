class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :boro
      t.integer :type
      t.string :hours
      t.string :website
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :stores, :latitude
    add_index :stores, :longitude
  end
end

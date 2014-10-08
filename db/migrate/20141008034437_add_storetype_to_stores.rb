class AddStoretypeToStores < ActiveRecord::Migration
  def change
    add_column :stores, :storetype, :integer
  end
end

class RemoveTypeFromStores < ActiveRecord::Migration
  def change
    remove_column :stores, :type, :integer
  end
end

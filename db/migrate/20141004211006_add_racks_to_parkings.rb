class AddRacksToParkings < ActiveRecord::Migration
  def change
    add_column :parkings, :racks, :integer
  end
end

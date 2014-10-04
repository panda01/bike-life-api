class AddAddressToParkings < ActiveRecord::Migration
  def change
    add_column :parkings, :address, :string
  end
end

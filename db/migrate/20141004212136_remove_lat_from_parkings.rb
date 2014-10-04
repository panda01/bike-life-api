class RemoveLatFromParkings < ActiveRecord::Migration
  def change
    remove_column :parkings, :latitiude, :float
  end
end

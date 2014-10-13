class RemoveHoursPhoneFromParkings < ActiveRecord::Migration
  def change
    remove_column :parkings, :hours, :string
    remove_column :parkings, :phone, :string
  end
end

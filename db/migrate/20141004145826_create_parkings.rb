class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.string :name
      t.string :phone
      t.boolean :isRack
      t.string :hours

      t.timestamps
    end
  end
end

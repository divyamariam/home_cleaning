class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :areacode
      t.float :latitude
      t.float :longitude
      t.string :address
      t.text :description
      t.string :title

      t.timestamps
    end
  end
end

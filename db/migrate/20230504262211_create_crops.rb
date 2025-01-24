class CreateCrops < ActiveRecord::Migration[7.0]
  def change
    create_table :crops do |t|
      t.string :title
      t.text :content
      t.string :work_number
      t.geometry :shape,  srid: 4326, using: :gist

      t.timestamps
    end
  end
end

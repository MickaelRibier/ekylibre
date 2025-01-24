class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :work_number
      t.geometry :shape,  srid: 4326, using: :gist
      t.text :content

      t.timestamps
    end
  end
end

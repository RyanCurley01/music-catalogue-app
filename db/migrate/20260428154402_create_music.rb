class CreateMusic < ActiveRecord::Migration[7.1]
  def change
    create_table :musics do |t|
      t.string :title
      t.string :album
      t.string :artist
      t.string :genre
      t.integer :rating
      t.date :release_date

      t.timestamps
    end
  end
end

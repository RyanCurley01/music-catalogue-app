class CreateMusics < ActiveRecord::Migration[7.1]
  def change
    create_table :musics do |t|
      t.string :title
      t.string :album
      t.string :artist
      t.date :release_date

      t.timestamps
    end
  end
end

class RenameMusicsToMusic < ActiveRecord::Migration[7.1]
  def change
    rename_table :musics, :music
  end
end

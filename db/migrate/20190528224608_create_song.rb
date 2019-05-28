class CreateSong < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :lyrics
      t.integer :artist_id

      t.timestamps
    end
  end
end

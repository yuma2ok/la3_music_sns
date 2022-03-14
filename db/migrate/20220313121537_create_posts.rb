class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :music_img
      t.string :artist_name
      t.string :album_name
      t.string :music_name
      t.string :music_sample
      t.text :comment
    end
  end
end

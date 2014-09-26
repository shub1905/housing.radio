class CreateQueueSongs < ActiveRecord::Migration
  def change
    create_table :queue_songs do |t|
      t.integer :song_id
      t.integer :user_id
      t.integer :status
    end
    add_index :queue_songs, :song_id, :unique => true
  end
end

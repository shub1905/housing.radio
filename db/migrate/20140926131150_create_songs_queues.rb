class CreateSongsQueues < ActiveRecord::Migration
  def change
    create_table :songs_queues do |t|
      t.integer :song_id
      t.integer :user_id
      t.integer :status
    end
    add_index :songs_queues, [:song_id, :user_id], :unique => true
  end
end

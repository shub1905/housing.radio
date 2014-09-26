class CreateUserQueueJoins < ActiveRecord::Migration
  def change
    create_table :user_queue_joins do |t|
      t.integer :queue_song_id
      t.integer :user_id
      t.integer :vote
    end
    add_index :user_queue_joins, [:user_id, :queue_song_id], :unique => true
  end
end

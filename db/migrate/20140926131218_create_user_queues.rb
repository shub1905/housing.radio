class CreateUserQueues < ActiveRecord::Migration
  def change
    create_table :user_queues do |t|
      t.integer :songs_queue_id
      t.integer :user_id
      t.integer :vote
    end
    add_index :user_queues, [:user_id, :songs_queue_id], :unique => true
  end
end

class CreateQueues < ActiveRecord::Migration
  def change
    create_table :queues do |t|
      t.integer :song_id
      t.integer :user_id
      t.integer :status
    end
  end
end

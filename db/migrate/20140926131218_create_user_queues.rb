class CreateUserQueues < ActiveRecord::Migration
  def change
    create_table :user_queues do |t|
      t.integer :queue_id
      t.integer :user_id
      t.integer :vote
    end
  end
end

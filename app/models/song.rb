class Song < ActiveRecord::Base
  has_many :songs_queues
  has_many :user_queues
end

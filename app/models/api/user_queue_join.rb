module Api
  class UserQueueJoin

    def self.upvote(song_id, user_id)
      queue_id = QueueSong.find_by_song_id(song_id).user_id rescue nil
      return "Already Voted" if ::UserQueueJoin.where(:queue_id => queue_id, :user_id => user_id).present?
      ::UserQueueJoin.create!(:queue_id => queue_id, :user_id => user_id, :vote => 1)
      return "Upvoted Successfully"
    end

    def self.downvote(song_id, user_id)
      queue_id = QueueSong.find_by_song_id(song_id).user_id rescue nil
      return "Already Voted" if ::UserQueueJoin.where(:queue_id => queue_id, :user_id => user_id).present?
      ::UserQueueJoin.create!(:queue_id => queue_id, :user_id => user_id, :vote => 0)
      return "Downvoted Successfully"
    end

  end
end
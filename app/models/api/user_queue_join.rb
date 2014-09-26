module Api
  class UserQueueJoin

    def self.upvote(song_id, user_id)
      return "Already Exists" if ::UserQueueJoin.where(:song_id => song_id, :user_id => user_id).present?
      ::UserQueueJoin.create!(:song_id => song_id, :user_id => user_id, :vote => 1)
      return "Upvoted Successfully"
    end

    def self.downvote(song_id, user_id)
      return "Already Exists" if ::UserQueueJoin.where(:song_id => song_id, :user_id => user_id).present?
      ::UserQueueJoin.create!(:song_id => song_id, :user_id => user_id, :vote => 0)
      return "Downvoted Successfully"
    end

  end
end
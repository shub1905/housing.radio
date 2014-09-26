module Api
  class SongsQueue
  
    def upvote(song_id, user_id)
      return "Already Exists" if ::SongsQueue.where(:song_id => song_id, :user_id => user_id).present?
      ::SongsQueue.create!(:song_id => song_id, :user_id => user_id, :vote => 1)
      return "Upvoted Successfully"
    end

    def downvote(song_id, user_id)
      return "Already Exists" if ::SongsQueue.where(:song_id => song_id, :user_id => user_id).present?
      ::SongsQueue.create!(:song_id => song_id, :user_id => user_id, :vote => 0)
      return "Downvoted Successfully"
    end
  
  end
end
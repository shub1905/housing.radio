module Api
  class QueueSong

    def self.enqueue(song_id, user_id)
      return "Song Already Exists in the Queue" if ::QueueSong.find_by_song_id(song_id).present?
      ::QueueSong.create!(:song_id => song_id, :user_id => user_id, :status => 2)
      return "Song Added to Now Playing Queue"
    end
  
  end
end
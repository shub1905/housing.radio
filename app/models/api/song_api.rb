module Api
  class SongApi
  
    def current_user
      
    end
  
    def get_songs(query)
      songs = Song.where("name like ?", query)
      return songs
    end
  
  end
end
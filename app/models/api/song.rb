module Api
  class Song
  
    def current_user
    end
  
    def get_songs(query)
      songs_by_name = ::Song.where("name like ?", query)
      songs_by_artist = ::Song.where("artist like ?", query)
      songs_by_album = ::Song.where("album like ?", query)

      songs_by_name | songs_by_artist | songs_by_album
    end
  
  end
end
module Api
  class Song
    
    def get_songs(query)
      songs_by_name = ::Song.where("name ilike ?", "%#{query}%")
      songs_by_artist = ::Song.where("artist ilike ?", "%#{query}%")
      songs_by_album = ::Song.where("album ilike ?", "%#{query}%")

      songs_by_name | songs_by_artist | songs_by_album
    end
  
  end
end
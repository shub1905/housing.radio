module Api
  class RadioController < ApiController

    def get_current_user
      render :json => current_user, :status => 200
    end

    def search_songs
      query = params[:q]
      api = Api::Song.new
      songs = api.get_songs(query)
      render json: songs
    end

    def enqueue
      song_id = params[:id].to_i
      user_id = current_user.id
      response = Api::QueueSong.enqueue(song_id, user_id)
      render json: response
    end

    def upvote_song
      song_id = params[:id].to_i
      user_id = current_user.id
      response = Api::UserQueue.upvote(song_id, user_id)
      render json: response
    end

    def downvote_song
      song_id = params[:id].to_i
      user_id = current_user.id
      response = Api::UserQueue.downvote(song_id, user_id)
      render json: response
    end

  end
end
module Api
  class SongApiController < ApiController
    def current_user
      api = SongApi.new
      current_user = api.current_user
      render :json => current_user, :status => 200
    end

    def get_songs
      query = params[:q]
      api = SongApi.new
      songs = api.get_songs
      render :json => songs, :status => 200
    end

  end
end
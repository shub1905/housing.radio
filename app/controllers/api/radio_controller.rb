module Api
  class RadioController < ApiController

    def current_user
      api = Api::Song.new
      current_user = api.current_user
      render :json => current_user, :status => 200
    end

    def search_songs
      query = params[:q]
      api = Api::Song.new
      songs = api.get_songs(query)
      render :json => songs, :status => 200
    end

  end
end
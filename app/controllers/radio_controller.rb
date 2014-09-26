class RadioController < ApplicationController
  def index
    @queue_songs = Song.first(10)
  end
end

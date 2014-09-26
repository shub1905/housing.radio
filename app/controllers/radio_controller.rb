class RadioController < ApplicationController
  def index
    @queue_songs = QueueSong.all
  end
end

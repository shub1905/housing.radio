class RadioController < ApplicationController
  PATH = "shubhamb.housing.com:3000/"

  def index
    @path = PATH
    @queue_songs = Song.first(10)
  #@queue_songs = @queue_songs.as_json
    
    
    #@queue_songs = @queue_songs.map{|e| e.merge("path" => URI.escape(PATH + e["path"], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")))}
    set_start_time if  !Redis.new.exists('start_time') 

    @offset = ((DateTime.now.to_i - Redis.new.get('start_time').to_i) * 1000).to_i
  end

  def self.broadcast_message(flag)
    result = {}

    current_queue_song = QueueSong.where(:status => 0).first # this should be only 1 current entry
    if current_queue_song.present?
      current_song = current_queue_song.song # this again should be only 1 entry
      current_song_added_by = current_queue_song.user
      current_song_score = UserQueueJoin.where(:queue_id => current_queue_song.user_id, :vote => 1).count -
                            UserQueueJoin.where(:queue_id => current_queue_song.user_id, :vote => 0).count
    end

    result[:current_song] = {:id => current_song.id, :path => PATH + current_song.path, 
     :added_by => current_song_added_by, :score => current_song_score}

     songs_arr = []
    queue_songs = QueueSong.where(:status => [1,2]).all # all songs other than current playing song
    queue_songs.each do |queue_song|
      if queue_song.present?
        song = queue_song.song
        added_by = queue_song.user
        song_score = UserQueueJoin.where(:queue_id => queue_song.user_id, :vote => 1).count -
                      UserQueueJoin.where(:queue_id => queue_song.user_id, :vote => 0).count
      end
      song_hash = {
        :type => QueueSong::STATUS_MAPPING[queue_song.status],
        :id => song.id,
        :path => PATH + song.path,
        :added_by => added_by,
        :score => song_score
      }
      songs_arr << song_hash
    end

    result[:songs] = songs_arr

    result
  end

  def set_start_time
    Redis.new.set('start_time',DateTime.now.to_i)
  end

  def reset_start_time
    Redis.new.del 'start_time'
  end

end

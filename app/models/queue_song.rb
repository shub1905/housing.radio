class QueueSong < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  
  STATUS_MAPPING = {0 => "playing", 1 => "fixed", 2 => "variable"}
end

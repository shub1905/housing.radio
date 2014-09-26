class SocketController < ApplicationController
  include Tubesock::Hijack

  def set_start_time
    Redis.new.set('start_time',DateTime.now.to_i)
  end

  def reset_start_time
    Redis.new.del 'start_time'
  end
  def test_player
    set_start_time unless Redis.new.exists('start_time')
    @offset = ((DateTime.now.to_i - Redis.new.get('start_time').to_i) * 1000).to_i
  end

  def broadcast
    hijack do |tubesock|
      # Listen on its own thread
      redis_thread = Thread.new do
        # Needs its own redis connection to pub
        # and sub at the same time
        Redis.new.subscribe "broadcast" do |on|
          on.message do |channel, message|
            tubesock.send_data message
          end
        end
      end

      tubesock.onmessage do |m|
        # pub the message when we get one
        # note: this echoes through the sub above
        Redis.new.publish "broadcast", m
      end
      
      tubesock.onclose do
        # stop listening when client leaves
        redis_thread.kill
      end
		end
	end
end

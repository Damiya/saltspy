require 'rubygems'
require 'SocketIO'

module Saltspy
  class Saltspy
    def launch
      client = SocketIO.connect('http://www-cdn-twitch.saltybet.com:8000') do
        before_start do
          #How do I lift this shit out into my class scope? God only knows

          require 'bunny'
          conn = Bunny.new
          conn.start
          @ch = conn.create_channel
          @exchange = @ch.default_exchange
          @last_message = nil
          on_message do |data|
            if @last_message != Time.now
              puts("[#{Time.now}] Message received")
              @exchange.publish('WEBSOCKET_UPDATED', :routing_key => 'com.itsdamiya.tradecaravan.update_stats')
              @last_message = Time.now
            else
              @last_message = nil
            end

            #  @count += 1
            #else
            #  @count = 0
            #end
          end
        end
      end
    end
  end
end
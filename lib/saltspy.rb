require "saltspy/version"

require 'SocketIO'

module Saltspy
  class Saltspy
    def launch
      client = SocketIO.connect("http://www-cdn-twitch.saltybet.com:8000") do
        before_start do
          on_message { |message| puts "incoming message: #{message}" }
          on_event('news') { |data| puts data.first } # data is an array fo things.
        end
      end
    end
  end
end
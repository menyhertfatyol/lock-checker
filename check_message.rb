require 'dotenv/load'
require 'uri'
require 'mqtt'
require_relative 'cloud_mqtt'

loop do
  Thread.new do
    MQTT::Client.connect(cloud_mqtt) do |c|
      c.get('doorlock') do |topic, message|
        puts "#{topic}: #{message}"
      end
    end
  end
end

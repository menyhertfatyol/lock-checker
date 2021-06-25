require 'dotenv/load'
require 'mqtt'
require 'uri'
require 'json'
require 'rpi_gpio'

RPi::GPIO.set_numbering :board
RPi::GPIO.setup 11, as: :input, pull: :up

def cloud_mqtt
  uri = URI.parse ENV['CLOUDMQTT_URL']
  {
    remote_host: uri.host,
    remote_port: uri.port,
    username: uri.user,
    password: uri.password,
  }
end

Thread.new do
  MQTT::Client.connect(cloud_mqtt) do |c|
    c.get('test') do |topic, message|
      puts "#{topic}: #{message}"
    end
  end
end

MQTT::Client.connect(cloud_mqtt) do |c|
  loop do
    if RPi::GPIO.high? 11
      state = 'open'
    else
      state = 'locked'
    end
    message = { state: state, created_at: Time.now }.to_json
    c.publish('test', message)
    sleep 1
  end
end

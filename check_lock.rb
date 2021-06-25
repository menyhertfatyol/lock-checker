require 'dotenv/load'
require 'mqtt'
require 'uri'
require 'json'
require 'rpi_gpio'

uri = URI.parse ENV['CLOUDMQTT_URL'] || 'mqtt://localhost:1883'
conn_opts = {
  remote_host: uri.host,
  remote_port: uri.port,
  username: uri.user,
  password: uri.password,
}

RPi::GPIO.set_numbering :board
RPi::GPIO.setup 11, as: :input, pull: :up

Thread.new do
  MQTT::Client.connect(conn_opts) do |c|
    c.get('test') do |topic, message|
      puts "#{topic}: #{message}"
    end
  end
end

MQTT::Client.connect(conn_opts) do |c|
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

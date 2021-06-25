require_relative 'bootstrap'
require_relative 'cloud_mqtt'

RPi::GPIO.set_numbering :board
RPi::GPIO.setup 11, as: :input, pull: :up

Thread.new do
  MQTT::Client.connect(cloud_mqtt) do |c|
    c.get('doorlock') do |topic, message|
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
    c.publish('doorlock', message)
    sleep 1
  end
end

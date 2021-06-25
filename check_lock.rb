require_relative 'bootstrap'

RPi::GPIO.set_numbering :board
RPi::GPIO.setup 11, as: :input, pull: :up

state = if RPi::GPIO.high? 11
  'open'
else
  'locked'
end

message = { state: state, created_at: Time.now }.to_json

MQTT::Client.connect(cloud_mqtt) do |c|
  c.publish('doorlock', message)
end

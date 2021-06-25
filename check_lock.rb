require_relative 'bootstrap'

RPi::GPIO.set_numbering :board
RPi::GPIO.setup 11, as: :input, pull: :up

MQTT::Client.connect(cloud_mqtt) do |c|
  state = if RPi::GPIO.high? 11
            'open'
          else
            'locked'
          end
  message = { state: state, created_at: Time.now }.to_json
  c.publish('doorlock', message)
  sleep 1
end

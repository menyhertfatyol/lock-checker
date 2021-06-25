require_relative 'bootstrap'

Thread.new do
  MQTT::Client.connect(cloud_mqtt) do |c|
    loop do
      c.get('doorlock') do |topic, message|
        puts "#{topic}: #{message}"
      end
    end
  end
end

loop {  }

require 'rpi_gpio'

RPi::GPIO.set_numbering :board
RPi::GPIO.setup 11, as: :input, pull: :up

begin
  loop do
    if RPi::GPIO.high? 11
      puts 'No magnet'
    else
      puts 'Magnet'
    end
    sleep 0.1
  end
rescue Interrupt
  RPi::GPIO.clean_up
end

class Door
  def self.check_lock_state
    RPi::GPIO.set_numbering :board
    RPi::GPIO.setup 11, as: :input, pull: :up

    if RPi::GPIO.high? 11
      Doorlock.create!(state: 'open')
    else
      Doorlock.create!(state: 'locked')
    end
  end
end

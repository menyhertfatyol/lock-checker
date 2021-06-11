require 'rails_helper'

RSpec.describe Door do
  subject(:check_lock_state) { described_class.check_lock_state }

  context 'when door is open' do
    before { allow(RPi::GPIO).to receive(:high?).and_return true }

    it 'saves the open state of the door lock' do
      expect(Doorlock).to receive(:create).with(state: 'open')
      expect { check_lock_state }.to change(Doorlock.all, :size).by(1)
    end
  end

  context 'when door is closed' do
    before { allow(RPi::GPIO).to receive(:high?).and_return false }

    it 'saves the locked state of the door lock' do
      expect(Doorlock).to receive(:create).with(state: 'locked')
      expect { check_lock_state }.to change(Doorlock.all, :size).by(1)
    end
  end
end

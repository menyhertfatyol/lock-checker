require 'rails_helper'

RSpec.describe Door do
  describe '#check_lock_state' do
    subject(:check_lock_state) { described_class.check_lock_state }

    context 'when door is open' do
      before { allow(RPi::GPIO).to receive(:high?).and_return true }

      it 'saves the open state of the door lock' do
        expect { check_lock_state }.to change(Doorlock.all, :size).by(1)
        expect(Doorlock).to have_received(:create!).with(state: 'open')
      end
    end

    context 'when door is closed' do
      before { allow(RPi::GPIO).to receive(:high?).and_return false }

      it 'saves the locked state of the door lock' do
        expect { check_lock_state }.to change(Doorlock.all, :size).by(1)
        expect(Doorlock).to have_received(:create!).with(state: 'locked')
      end
    end
  end
end

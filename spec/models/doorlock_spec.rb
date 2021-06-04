require 'rails_helper'

RSpec.describe Doorlock, type: :model do
  it { should validate_presence_of(:state) }
end

require 'rails_helper'

RSpec.describe Doorlock, type: :model do
  it { is_expected.to validate_presence_of(:state) }

  it {
    is_expected.to validate_inclusion_of(:state)
      .in_array(%w[open locked])
  }
end

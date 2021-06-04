class Doorlock < ApplicationRecord
  validates_presence_of :state
  validates_inclusion_of :state, in: %w[open locked]
end

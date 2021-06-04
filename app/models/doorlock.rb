class Doorlock < ApplicationRecord
  validates_presence_of :state
end

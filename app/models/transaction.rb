class Transaction < ApplicationRecord
  validates_presence_of :payer, :points
end

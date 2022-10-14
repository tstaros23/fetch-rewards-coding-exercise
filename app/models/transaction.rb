class Transaction < ApplicationRecord
  validates_presence_of :payer, :points

  def self.order_transactions
    order(:created_at)
  end
end

class Transaction < ApplicationRecord
  validates_presence_of :payer, :points

  def self.order_transactions
    order(:created_at)
  end

  def self.spend_points(points)
    hash = Hash.new(0)
    total = points
    wip = order_transactions.map do |transaction|
      if transaction.points > total
        hash[transaction.payer] -= total
        total = 0
        break
      else
      hash[transaction.payer] -= transaction.points
        total -= transaction.points
      end
    end
    hash
  end
end
# wip = order_transactions.map do |transaction|
#   if transaction.points > total
#     hash[transaction.payer] -= total - transaction.points
#   else
#   hash[transaction.payer] -= transaction.points
#     total -= transaction.points
#   end
# end
# require "pry"; binding.pry
# end
# end

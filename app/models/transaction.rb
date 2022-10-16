class Transaction < ApplicationRecord
  validates_presence_of :payer, :points

  def self.order_transactions
    order(:created_at)
  end

  def self.spend_points(points)
    hash = Hash.new(0)
    total = points
    array = []
    wip = order_transactions.map do |transaction|
      if transaction.points > total
        hash[transaction.payer] -= total
        total = 0
        array << Transaction.find(transaction.id)
        break
      else
      hash[transaction.payer] -= transaction.points
        total -= transaction.points
        array << Transaction.find(transaction.id)
      end
    end
    return array, hash
  end

  # def self.batch_update(transactions)
  #   grouped_transactions = transactions.index_by do |transaction|
  #     transaction[:id]
  #   end
  # end
end
#make a where statement in model that tells when to update all. then call then call it in the controller and render it to json
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

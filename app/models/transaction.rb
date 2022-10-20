class Transaction < ApplicationRecord
  validates_presence_of :payer, :points

  def self.order_transactions
    order(:created_at)
  end

  def self.spend_points_and_update_sum(points)
    hash = Hash.new(0)
    total = points
    order_transactions.map do |transaction|
      if transaction.points > total
        hash[transaction.payer] -= total
        total = 0
        Transaction.find(transaction.id).update(points: (transaction.points + hash[transaction.payer]) )
        break
      else
      hash[transaction.payer] -= transaction.points
        total -= transaction.points
        Transaction.find(transaction.id).update(points: 0)
      end
    end
    hash
  end
end

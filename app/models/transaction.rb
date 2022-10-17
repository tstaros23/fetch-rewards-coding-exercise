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

  def self.sum_and_update_transactions(transactions)
    transactions[1].select do |k,v|
      if k.include?(transactions[0].last[:payer])
        transactions[0].last[:points] += v
        transaction = Transaction.update(transactions[0].last.id, points: transactions[0].last[:points])
        other_transactions = transactions[0][0..-2]
        other_transactions.update_all(points: 0)
      end
    end
  end
end

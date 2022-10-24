class Transaction < ApplicationRecord
  validates_presence_of :payer, :points

  def self.order_transactions
    order(:created_at)
  end

  def self.spend_points_and_update_sum(points)
    hash = Hash.new(0)
    points = points.to_i

    order_transactions.map do |transaction|
      if transaction.points > points
        hash[transaction.payer] -= points
        points += hash[transaction.payer]
        Transaction.find(transaction.id).update(points: (transaction.points + hash[transaction.payer]) )
        break
      elsif transaction.points < points && transaction.points.negative?
        hash[transaction.payer] -= transaction.points
        points -= transaction.points
        transaction.points -= transaction.points
        Transaction.find(transaction.id).update(points: transaction.points)
      else
      hash[transaction.payer] -= transaction.points
        points -= transaction.points
        Transaction.find(transaction.id).update(points: (hash[transaction.payer] + transaction.points))
      end
    end
    hash
  end

  def self.add_sum_of_points(transactions)
  sum = Hash.new(0)
   transactions.each_with_object(sum) do |obj, sum|
     sum[obj.payer] += obj.points
    end
  end
end

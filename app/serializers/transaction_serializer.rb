class TransactionSerializer
  def self.format_json(transaction)
    {
      "payer": transaction.payer,
      "points": transaction.points,
      "timestamp": transaction.created_at&.strftime('%m/%d/%Y')
    }
  end

  def self.spent_json(transactions)
    transactions.map do |k,v|
      {
        "payer": k,
        "points": v
      }
    end
  end
end

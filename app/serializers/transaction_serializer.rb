class TransactionSerializer
  def self.format_json(transaction)
    {
      "payer": transaction.payer,
      "points": transaction.points,
      "timestamp": transaction.created_at.strftime('%m/%d/%Y')
    }
  end
end

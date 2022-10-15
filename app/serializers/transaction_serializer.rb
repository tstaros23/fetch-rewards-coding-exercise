class TransactionSerializer
  def self.format_json(transaction)
    {
      "payer": transaction.payer,
      "points": transaction.points,
      "timestamp": transaction.created_at&.strftime('%m/%d/%Y')
      #First you have to make sure if there is 'request_date' filled before you create a record by applying ActiveRecord validations.
      # Secondly, you can use ruby's try method to avoid such exceptions
      #In the newer version of Ruby, you can use &. -> lonely operator instead
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

class Api::V1::TransactionsController < ApplicationController
  def create
    created_transaction = Transaction.create(transaction_params)
  end

  private
    def transaction_params
      params.permit(:payer, :points, :timestamp)
    end
end

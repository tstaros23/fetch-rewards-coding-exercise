class Api::V1::TransactionsController < ApplicationController
  def create
    created_transaction = Transaction.create(transaction_params)
    balance = render json: TransactionSerializer.format_json(created_transaction), status: :created
  end

  def update
    updated_transactions = Transaction.spend_points(params[:points])
    Transaction.sum_and_update_transactions(updated_transactions)
    spent = render json: TransactionSerializer.spent_json(updated_transactions)
  end
  private
    def transaction_params
      params.permit(:payer, :points)
    end
end

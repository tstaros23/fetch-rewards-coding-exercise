class Api::V1::TransactionsController < ApplicationController
  def create
    created_transaction = Transaction.create(transaction_params)
    balance = render json: TransactionSerializer.format_json(created_transaction), status: :created
  end

  def update
    transaction = Transaction.find(params[:id])
    if !transaction.nil?
      updated_transaction = Transaction.update(transaction.id, transaction_params)
      updated_balance = render json: TransactionSerializer.format_json(updated_transaction)
    else
      render json: {errors: {details: "transaction doesn't exist"}}, status: :not_found
    end
  end
  private
    def transaction_params
      params.require(:transaction).permit(:payer, :points)
    end
end
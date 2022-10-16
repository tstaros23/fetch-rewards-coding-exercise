class Api::V1::TransactionsController < ApplicationController
  def create
    created_transaction = Transaction.create(transaction_params)
    balance = render json: TransactionSerializer.format_json(created_transaction), status: :created
  end

  def update
    updated_values = Transaction.spend_points(params[:points])
    #update where transaction has key in updated_values
    spent = render json: TransactionSerializer.spent_json(updated_values)
    # if !transactions.nil?
    #   grouped_transactions = transactions.index_by { |transaction| } transaction[:id]
    #   updated_transactions = Transaction.update(grouped_transactions.keys, grouped_transactions.values)
    #   render json: TransactionSerializer.format_json(updated_transaction)
    # else
    #   render json: {errors: {details: "transaction doesn't exist"}}, status: :not_found
    # end
  end
  private
    def transaction_params
      params.permit(:payer, :points,)
    end
end

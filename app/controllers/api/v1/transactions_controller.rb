class Api::V1::TransactionsController < ApplicationController
  def create
    created_transaction = Transaction.create(transaction_params)
    balance = render json: TransactionSerializer.new(created_transaction), status: :created
  end

  private
    def transaction_params
      params.require(:transaction).permit(:payer, :points)
    end
end

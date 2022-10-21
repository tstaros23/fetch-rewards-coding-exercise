class Api::V1::TransactionsController < ApplicationController
  def create
    created_transaction = Transaction.create(transaction_params)
    balance = render json: TransactionSerializer.format_json(created_transaction), status: :created
  end

  def update
    transactions = Transaction.all
    if !params[:points].nil? && !transactions.empty?
      updated_transactions = Transaction.spend_points_and_update_sum(params[:points])
      spent = render json: TransactionSerializer.spent_json(updated_transactions)
    elsif params[:points].nil?
      render json: {errors: {details: "user has no points to spend"}}, status: :not_found
    elsif transactions.empty?
      render json: {errors: {details: "transaction doesn't exist"}}, status: :not_found
    end
  end
  private
    def transaction_params
      params.permit(:payer, :points)
    end
end

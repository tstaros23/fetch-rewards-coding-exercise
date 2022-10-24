class Api::V1::TransactionsController < ApplicationController
  def index
    transactions = Transaction.all
    if transactions.nil?
      render json: {}
    else
      render json: Transaction.add_sum_of_points(transactions)
    end
  end

  def create
    if params["payer"].nil? || params["points"].nil?
      render json: {errors: {details: "Field missing"}}, status: :bad_request
    else
      created_transaction = Transaction.create(transaction_params)
      balance = render json: TransactionSerializer.format_json(created_transaction), status: :created
    end
  end

  def update
    if params[:points].nil? || Transaction.all.empty?
      render json: {errors: {details: "Field missing"}}, status: :bad_request
    else
      updated_transactions = Transaction.spend_points_and_update_sum(params[:points])
      render json: TransactionSerializer.spent_json(updated_transactions)
    end
  end
  private
    def transaction_params
      params.permit(:payer, :points)
    end
end

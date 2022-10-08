require 'rails_helper'

 RSpec.describe 'Transactions API' do
   it "can create a new Item" do
    params = item_params = { "payer": "DANNON", "points": 1000, "timestamp": "2020-11-02T14:00:00Z" }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/transactions", headers: headers, params: JSON.generate(transaction: params)
    created_transaction = Transaction.last
    expect(response.status).to eq(201)

    transaction_data = created_transaction = JSON.parse(response.body, symbolize_names: true)

    expect(transaction_data[:data]).to have_key(:id)
    expect(transaction_data[:data]).to have_key(:type)
    expect(transaction_data[:data]).to have_key(:attributes)
    expect(transaction_data[:data][:attributes]).to have_key(:payer)
    expect(transaction_data[:data][:attributes]).to have_key(:points)
  end
 end

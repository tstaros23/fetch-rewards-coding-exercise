require 'rails_helper'

 RSpec.describe 'Transactions API' do
   it "can create a new Transaction" do
    transaction_params = {
                          "payer": "DANNON",
                          "points": 1000,
                          "timestamp": "2020-11-02T14:00:00Z"
                          }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/transactions", headers: headers, params: JSON.generate(transaction: transaction_params)
    created_transaction = Transaction.last
    expect(response.status).to eq(201)

    transaction_data = created_transaction = JSON.parse(response.body, symbolize_names: true)

    expect(transaction_data).to have_key(:payer)
    expect(transaction_data).to have_key(:points)
    expect(transaction_data).to have_key(:timestamp)
  end

  it "can update an existing Transaction" do
    id = create(:transaction).id
    previous_points = Transaction.last.points
    previous_payer = Transaction.last.payer
    transaction_params = {
                          "payer": "DANNON",
                          "points": 1000,
                          "timestamp": "2020-11-02T14:00:00Z"
                          }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/transactions/#{id}", headers: headers, params: JSON.generate(transaction: transaction_params)

    transaction = Transaction.find_by(id: id)

    expect(response).to be_successful
    expect(transaction.payer).to_not eq(previous_payer)
    transaction_data = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
  end
 end

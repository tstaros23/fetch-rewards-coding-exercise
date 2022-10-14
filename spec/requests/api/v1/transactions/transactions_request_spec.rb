require 'rails_helper'

 RSpec.describe 'Transactions API' do
   it "can create a new Transaction" do
    transaction_params = {
                          "payer": "DANNON",
                          "points": 1000,
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

  it "can spend reward points" do
    transaction_1 = Transaction.create!(payer: "DANNON", points: 200, created_at: '2022/10/11')
    transaction_2 = Transaction.create!(payer: "DANNON", points: -50, created_at: '2022/10/12')
    transaction_3 = Transaction.create!(payer: "MILLER COORS", points: 1000, created_at: '2022/10/13')
    transaction_4 = Transaction.create!(payer: "DANNON", points: 1000, created_at: '2022/10/14')

    params = {"points": 1000}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/transactions", headers: headers, params: JSON.generate(params)

    expect(response).to be_successful
    transaction_data = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
  end
 end

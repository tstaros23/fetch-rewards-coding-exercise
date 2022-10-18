require "rails_helper"

describe Transaction, type: :model do
  describe "validations" do
    it {should validate_presence_of(:payer)}
    it {should validate_presence_of(:points)}
  end

  it "can find all transactions in order from when they are created" do
    transaction_1 = Transaction.create!(payer: "DANNON", points: 200, created_at: '2022/10/12')
    transaction_2 = Transaction.create!(payer: "DANNON", points: -50, created_at: '2022/10/11')
    transaction_3 = Transaction.create!(payer: "MILLER COORS", points: 1000, created_at: '2022/10/13')

    expect(Transaction.order_transactions).to eq([transaction_2, transaction_1, transaction_3])
  end

  it "can spend points" do
    transaction_1 = Transaction.create!(payer: "DANNON", points: 200, created_at: '2022/10/11')
    transaction_2 = Transaction.create!(payer: "DANNON", points: -50, created_at: '2022/10/12')
    transaction_3 = Transaction.create!(payer: "MILLER COORS", points: 1000, created_at: '2022/10/13')
    transaction_4 = Transaction.create!(payer: "DANNON", points: 1000, created_at: '2022/10/14')

    expected = [[transaction_1, transaction_2, transaction_3],
      {"DANNON" => -150,
      "MILLER COORS" => -850}
    ]

    expect(Transaction.spend_points(1000)).to eq(expected)
  end

  it "can update points" do
    transactions = [[transaction_1 = Transaction.create!(payer: "DANNON", points: 200, created_at: '2022/10/11'),
    transaction_2 = Transaction.create!(payer: "DANNON", points: -50, created_at: '2022/10/12'),
    transaction_3 = Transaction.create!(payer: "MILLER COORS", points: 1000, created_at: '2022/10/13')], {"DANNON" => -150,
    "MILLER COORS" => -850}]
    # have 6 transactions
    # spend points till we run out for the first 3 updated transactions in this case.
    # remainder for the last of the updated transactions
    # the ones before it, will have zero points and those i want to update all of them to zero
    Transaction.sum_and_update_transactions(transactions)

    expect(transaction_1.points).to eq(0)
    expect(transaction_2.points).to eq(0)
    expect(transaction_3.points).to eq(150)
  end
end

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
    #store hash number values
    #iterate through ordered transactions payed points until total points to spend goes to zero
    #positive numbers become negative and negative become positive when adding hash values.
    # each time reward points are spent, the total reward points decreases.
    # only spend until total becomes zero and then stop

    expect(Transaction.spend_points(1000)).to eq(expected)
  end

  it "can update points" do
    transactions = [transaction_1 = Transaction.create!(payer: "DANNON", points: 200, created_at: '2022/10/11'),
    transaction_2 = Transaction.create!(payer: "DANNON", points: -50, created_at: '2022/10/12'),
    transaction_3 = Transaction.create!(payer: "MILLER COORS", points: 1000, created_at: '2022/10/13')]

    expected = [
      transaction_1 = Transaction.create!(payer: "DANNON", points: 0, created_at: '2022/10/11'),
      transaction_2 = Transaction.create!(payer: "DANNON", points: 0, created_at: '2022/10/12'),
      transaction_3 = Transaction.create!(payer: "MILLER COORS", points: 150, created_at: '2022/10/13')
    ]
    expect(Transaction.batch_update(transactions)).to eq(expected)
  end
end

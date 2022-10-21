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
    transaction_4 = Transaction.create!(payer: "DANNON", points: 1000, created_at: '2022/10/14')

    expect(Transaction.order_transactions).to eq([transaction_2, transaction_1, transaction_3, transaction_4])
  end

  it "can spend points" do
    transaction_1 = Transaction.create!(payer: "DANNON", points: 200, created_at: '2022/10/11')
    transaction_2 = Transaction.create!(payer: "DANNON", points: -50, created_at: '2022/10/12')
    transaction_3 = Transaction.create!(payer: "MILLER COORS", points: 1000, created_at: '2022/10/13')
    transaction_4 = Transaction.create!(payer: "DANNON", points: 1000, created_at: '2022/10/14')

    expected =
      {"DANNON" => -150,
      "MILLER COORS" => -850}

    expect(Transaction.spend_points_and_update_sum(1000)).to eq(expected)
  end

  it "can update the sum of points" do
    transaction_1 = Transaction.create!(payer: "DANNON", points: 200, created_at: '2022/10/11')
    transaction_2 = Transaction.create!(payer: "DANNON", points: -50, created_at: '2022/10/12')
    transaction_3 = Transaction.create!(payer: "MILLER COORS", points: 1000, created_at: '2022/10/13')
    transaction_4 = Transaction.create!(payer: "DANNON", points: 1000, created_at: '2022/10/14')

    transactions = Transaction.all
    expect(transactions.first.points).to eq(200)
    expect(transactions.second.points).to eq(-50)
    expect(transactions.third.points).to eq(1000)
    expect(transactions.fourth.points).to eq(1000)

    Transaction.spend_points_and_update_sum(1000)

    transactions = Transaction.all
    expect(transactions.first.points).to eq(0)
    expect(transactions.second.points).to eq(0)
    expect(transactions.third.points).to eq(150)
    expect(transactions.fourth.points).to eq(1000)
  end

  it "can add up the sum all of the transactions" do
    transactions = [Transaction.create!(payer: "DANNON", points: 0, created_at: '2022/10/11'),
    Transaction.create!(payer: "DANNON", points: 0, created_at: '2022/10/12'),
    Transaction.create!(payer: "MILLER COORS", points: 150, created_at: '2022/10/13'),
    Transaction.create!(payer: "DANNON", points: 1000, created_at: '2022/10/14')]

    expected = {
      payer: "DANNON", points: 1000,
      payer: "MILLER COORS", points: 150
    }

    expect(Transaction.add_sum_of_points(transactions)).to eq(expected)
  end
end

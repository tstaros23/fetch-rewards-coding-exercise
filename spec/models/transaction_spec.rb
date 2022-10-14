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
end

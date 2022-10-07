require "rails_helper"

describe Transaction, type: :model do
  describe "validations" do
    it {should validate_presence_of(:payer)}
    it {should validate_presence_of(:points)}
  end
end

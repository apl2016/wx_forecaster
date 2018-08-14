require "rails_helper"

RSpec.describe Address, :type => :model do

  let(:address) { build :address }

  it "is valid when attributes are valid" do
    expect(address).to be_valid
  end

  context "invalid attributes" do
    it "is invalid without a street" do
      address.street = ''
      expect(address).not_to be_valid
    end

    it "is invalid without a city" do
      address.city = ''
      expect(address).not_to be_valid
    end

    it "is invalid without a state" do
      address.state = ''
      expect(address).not_to be_valid
    end

    it "is invalid without a zipcode" do
      address.zip = ''
      expect(address).not_to be_valid
    end
  end
end

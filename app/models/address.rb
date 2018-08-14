class Address
  include ActiveModel::Model

  attr_accessor :street, :city, :state, :zip
  validates :street, :city, :state, :zip, presence: true

end

class ForecastController < ApplicationController
  def new
    puts "<<<< in new >>>>>>>"
  end

  def get_forecast
    puts "--- in get_forecast ----------"
    puts "params:"
    p params

    puts "params[:address][:zip]]"
    p params[:address][:zip]

    address = Address.new(params[:address])

    puts "address object:"
    p address

    puts "address.valid? - #{address.valid?}"
  end
end

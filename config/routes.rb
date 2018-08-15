Rails.application.routes.draw do
  root 'forecast#address_input'

  get 'forecast/address_input' => 'forecast#address_input'
  post 'forecast/get_forecast' => 'forecast#get_forecast'
end

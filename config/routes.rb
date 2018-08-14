Rails.application.routes.draw do
  root 'forecast#new'

  post 'forecast/get_forecast' => 'forecast#get_forecast'
end

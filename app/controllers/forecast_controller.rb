class ForecastController < ApplicationController

  def address_input
  end

  def get_forecast
    address = Address.new(address_params)
    if address.valid?
      weather_data = get_weather(params[:address][:zip])
      if weather_data.nil?
        redirect_to({ action: :address_input }, flash: { error: "Problem getting forecast data.  Please try again later." })
      else
        @city_name = weather_data['city']['name']
        @forecast_data = build_forecast_data(weather_data)
      end
    else
      redirect_to({ action: :address_input }, flash: { error: address.errors.full_messages.join(', ') })
    end
  end

  private

  # Receives raw weather data from API and returns forecast data to be displayed
  # forecast_data =  {
  #                    '8/17': [{ time: '6PM', condition: 'clear', temp_min: 80 , temp_max: 88 },
  #                              { time: '12AM', condition: 'clear', temp_min: 80 , temp_max: 88 }, ...],
  #                    '8/18': [{ time: '6AM', condition: 'clear', temp_min: 80 , temp_max: 88 },
  #                              { time: '12PM', condition: 'clear', temp_min: 80 , temp_max: 88 }, ...]
  #                 }
  def build_forecast_data(weather_data)
    forecast_data = {}
    weather_data['list'].each do |data|
      date_time = data['dt_txt'].to_datetime
      month_day = date_time.month.to_s + '/' + date_time.day.to_s
      forecast = {
        time: ((date_time.hour == 12 || date_time.hour == 0) ? 12 : date_time.hour % 12).to_s + "#{date_time.hour < 12 ? 'AM' : 'PM'}",
        condition: data['weather'].first['main'],
        temp_min: (data['main']['temp_min']).to_i.round,
        temp_max: (data['main']['temp_max']).to_i.round
      }
      forecast_data[month_day] = forecast_data[month_day].nil? ? [forecast] : forecast_data[month_day] << forecast
    end
    forecast_data
  end

  # read about this API at https://openweathermap.org/forecast5
  def get_weather(zip)
    @from_cache = true
    Rails.cache.fetch(zip, expires_in: 30.minutes) do
      @from_cache = false
      api_key = '' # set this or the call won't work!
      uri = URI.parse("http://api.openweathermap.org/data/2.5/forecast?zip=#{zip}&units=imperial&appid=#{api_key}")
      resp = Net::HTTP.get_response(uri)
      resp.code == '200' ? JSON.parse(resp.body) : nil
    end
  end

  def address_params
    params.require(:address).permit(:street, :city, :state, :zip)
  end
end

require "rails_helper"

RSpec.describe ForecastController do

  let(:address) { build :address }
  let(:test_city_name) { "Newport News" }
  let(:test_weather_data) {{
    "cod"=>"200",
    "message"=>0.0052,
    "cnt"=>40,
    "list" => [ {"dt"=>1534280400, "main"=>{"temp"=>87.78, "temp_min"=>84.89, "temp_max"=>87.78, "pressure"=>1026.87, "sea_level"=>1027.16, "grnd_level"=>1026.87, "humidity"=>86, "temp_kf"=>1.61}, "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01d"}], "clouds"=>{"all"=>0}, "wind"=>{"speed"=>9.64, "deg"=>251.501}, "sys"=>{"pod"=>"d"}, "dt_txt"=>"2018-08-14 21:00:00"},
                {"dt"=>1534291200, "main"=>{"temp"=>86.43, "temp_min"=>84.26, "temp_max"=>86.43, "pressure"=>1027.25, "sea_level"=>1027.58, "grnd_level"=>1027.25, "humidity"=>85, "temp_kf"=>1.21}, "weather"=>[{"id"=>801, "main"=>"Clouds", "description"=>"few clouds", "icon"=>"02n"}], "clouds"=>{"all"=>12}, "wind"=>{"speed"=>11.43, "deg"=>256.503}, "sys"=>{"pod"=>"n"}, "dt_txt"=>"2018-08-15 00:00:00"}
              ],
    "city" => { "id" => 420038240,
                "name" => test_city_name,
                "coord" => {"lat"=>37.0482, "lon"=>-76.4094},
                "country"=>"US" }
    }}
    let(:test_forecast_data) {{ "8/14" => [{:time=>"9PM", :condition=>"Clear", :temp_min=>84, :temp_max=>87}],
                                "8/15"=>[{:time=>"12AM", :condition=>"Clouds", :temp_min=>84, :temp_max=>86}] }}

  describe "GET address_input" do
    it "renders address_input view" do
      get :address_input
      expect(response).to render_template("address_input")
    end
  end

  describe "POST get_forecast" do
    before(:each) do
      # avoid hitting 3rd party API when testing
      allow_any_instance_of(ForecastController).to receive(:get_weather).and_return(test_weather_data)
      post :get_forecast, params: { address: attributes_for(:address) }
    end

    it "renders the get_forecast template" do
      expect(response).to render_template("get_forecast")
    end

    it "sets @city_name instance variable" do
      expect(assigns(:city_name)).to eq(test_city_name)
    end

    it "sets @forecast_data instance variable" do
      expect(assigns(:forecast_data)).to eq(test_forecast_data)
    end
  end
end

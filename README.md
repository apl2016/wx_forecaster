# README

## Setup
`bundle install`

**IMPORTANT**
In order for the weather API call to work, you must enter the given API key into
`ForecastController#get_weather` at variable `api_key` (on/near line 51)

To get Rails caching to work in development mode, toggle caching with:
`bin/rails dev:cache`

## Run
`rails server`
Navigate browser to `localhost:3000`

## Testing
`bundle exec rspec`

## General Info
This app gets weather forecast from OpenWeatherMap.  Read more at:
https://openweathermap.org/forecast5

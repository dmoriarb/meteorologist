require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

coord=@lat+","+@lng
url2 = "https://api.darksky.net/forecast/edf7ebf38240e9a09c2f3abcbdb81c52/"+coord
parsed_dati = JSON.parse(open(url2).read)

    @current_temperature = parsed_dati["currently"]["temperature"]

    @current_summary = parsed_dati["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_dati["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_dati["hourly"]["summary"]

    @summary_of_next_several_days = parsed_dati["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end

require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================

    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address_without_spaces
    parsed_data = JSON.parse(open(url).read)
    lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    lng = parsed_data["results"][0]["geometry"]["location"]["lng"]
coord= [lat,lng].to_sentence(two_words_connector: ',')
    url2 = "https://api.darksky.net/forecast/edf7ebf38240e9a09c2f3abcbdb81c52/"+coord
    parsed_dati = JSON.parse(open(url2).read)

    @current_temperature = parsed_dati["currently"]["temperature"]

    @current_summary = parsed_dati["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_dati["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_dati["hourly"]["summary"]

    @summary_of_next_several_days = parsed_dati["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end

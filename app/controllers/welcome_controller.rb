class WelcomeController < ApplicationController
  
 
	def index
  @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC).sort!

  response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")

  @location = response['location']['city']
  @temp_f = response['current_observation']['temp_f']
  @temp_c = response['current_observation']['temp_c']
  @weather_icon = response['current_observation']['icon_url']
  @weather_words = response['current_observation']['weather']
  @forecast_link = response['current_observation']['forecast_url']
  @real_feel_f = response['current_observation']['feelslike_f']
  @real_feel_c = response['current_observation']['feelslike_c']

  if params[:city] != nil
    params[:city].gsub!(" ", "_")
  end

  if params[:state] != "" && params[:city] != ""
    if params[:state] != nil && params[:city] != nil
      response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")
    end
  else
    response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")
  end

  if @weather_words == "Clear"
 			@url = ("https://static.pexels.com/photos/205335/pexels-photo-205335.jpeg")
	elsif @weather_words == "Partly Cloudy"
 			@url = ("https://static.pexels.com/photos/227513/pexels-photo-227513.jpeg")
  elsif @weather_words == "Rainy"
      @url = ("https://static.pexels.com/photos/110874/pexels-photo-110874.jpeg")
 	elsif @weather_words == "Windy"
 			@url = ("https://static.pexels.com/photos/149671/pexels-photo-149671.jpeg")
 	else @weather_words == "Snow"
 			@url = ("https://static.pexels.com/photos/6672/snow-forest-trees-winter.jpeg")
 	end	
end
 def test
      response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")
  
    @location = response['location']['city']
    @temp_f = response['current_observation']['temp_f']
    @temp_c = response['current_observation']['temp_c']
    @weather_icon = response['current_observation']['icon_url']
    @weather_words = response['current_observation']['weather']
    @forecast_link = response['current_observation']['forecast_url']
    @real_feel_f = response['current_observation']['feelslike_f']
    @real_feel_c = response['current_observation']['feelslike_c']
  end
 end

 

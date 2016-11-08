class WelcomeController < ApplicationController
  
 
	def index


      @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC).sort!

  response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")

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


  @location = response['location']['city']
  @temp_f = response['current_observation']['temp_f']
  @temp_c = response['current_observation']['temp_c']
  @weather_icon = response['current_observation']['icon_url']
  @weather_words = response['current_observation']['weather']
  @forecast_link = response['current_observation']['forecast_url']
  @real_feel_f = response['current_observation']['feelslike_f']
  @real_feel_c = response['current_observation']['feelslike_c']

  if @weather_words == "Clear"
 			@url = "https://pixabay.com/static/uploads/photo/2015/09/02/12/57/stars-918777_1280.jpg"
	elsif @weather_words == "Partly Cloudy"
 			@url = "https://pixabay.com/static/uploads/photo/2016/02/19/10/51/clouds-1209444_1280.jpg"
 	elsif @weather_words == "Windy"
 			@url = "https://pixabay.com/static/uploads/photo/2015/11/18/11/24/windrader-1048981_1280.jpg"
 	elsif @weather_words == "Mostly Cloudy"
 			@url = "https://pixabay.com/static/uploads/photo/2016/06/22/16/22/clouds-1473311_1280.jpg"
 	else @weather_words == "Snow"
 			@url = "https://pixabay.com/static/uploads/photo/2014/02/07/10/19/winter-260817_1280.jpg"
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

 

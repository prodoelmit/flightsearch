class AirlinesController < ApplicationController
  def all
    @airlines = Airline.all
    if @airlines.nil?
      render json: {error: "Couldn't get airlines list"}, status: 404
    else
      render json: @airlines.to_json
    end


  end
end

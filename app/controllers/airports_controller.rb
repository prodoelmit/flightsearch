class AirportsController < ApplicationController
  def find
    query = params[:query]
    @airports = Airport.find(query, sort: true)

    if @airports.nil?
      render json: {"error": "Couldn't fetch airports list"}, status: 404
    else
      render json: @airports.to_json
    end

  end
end

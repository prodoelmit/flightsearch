class FlightsController < ApplicationController
  def find
    respond_to do |format|
      format.json do
        date = params[:date]
        from_code = params[:from]
        to_code = params[:to]

        airlines = Airline.all
        @flights = []

        airlines.each do |airline|
          airline_flights = airline.flights(date: date, from: from_code, to: to_code)
          @flights += airline_flights unless airline_flights.nil?
        end
        render json: @flights.to_json
      end
      format.html {redirect_to root_path}
    end

  end
end

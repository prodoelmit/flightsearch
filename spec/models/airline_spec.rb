require 'rails_helper'

describe Airline do
  it { is_expected.to respond_to(:flights).with_keywords(:date,:from,:to) }
  it { is_expected.to respond_to(:flights_query_url).with_keywords(:date,:from,:to) }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:name) }

  it "should be constructable with hash" do
    obj = { code: "ZIA",
             name: "Zhukovsky international airport" 
    }

    a = Airline.new(obj)
    expect(a.code).to be == obj[:code]
    expect(a.name).to be == obj[:name]

  end

  it "should construct appropriate query based on date, from, to" do
    c1 = "ZIA"
    c2 = "DME"
    c_airline = "SU"
    ap1 = Airport.new({ airportCode: c1 })
    ap2 = Airport.new({ airportCode: c2 })
    airline = Airline.new({ code: c_airline })
    date = Date.new(1993,06,07)
    query_url = airline.flights_query_url(date: date, from: ap1, to: ap2)
    expect(query_url).to be == URI::HTTP.build(host: "node.locomote.com",
                    path: "/code-task/flight_search/#{c_airline}",
                    query: {date: date,
                            from: c1,
                            to: c2
                    }.to_query
                   )
  end

end

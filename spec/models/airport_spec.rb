require 'rails_helper'

describe Airport do
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:cityName) }
  it { is_expected.to respond_to(:cityCode) }
  it { is_expected.to respond_to(:name) }

  it "should be constructable with hash" do
    obj = { "airportCode" => "ZIA",
            "airportName" => "Zhukovsky international airport",
            "cityCode" => "ZHU",
            "cityName" => "Zhukovsky",
            "countryCode" => "RU",
            "countryName" => "Russian Federation",
            "latitude" => 55.561681, 
            "longitude" => 38.117886,
            "stateCode" => "",
            "timeZone" => "Russia/Moscow"
    }

    a = Airport.new(obj)
    expect(a.code).to be == obj["airportCode"]
    expect(a.name).to be == obj["airportName"]
    expect(a.cityCode).to be == obj["cityCode"]
    expect(a.cityName).to be == obj["cityName"]
    expect(a.countryCode).to be == obj["countryCode"]
    expect(a.countryName).to be == obj["countryName"]
    expect(a.latitude).to be == obj["latitude"]
    expect(a.longitude).to be == obj["longitude"]
    expect(a.stateCode).to be == obj["stateCode"]
    expect(a.timeZone).to be == obj["timeZone"]
  end


  it "should be able to find airports" do
    expect(Airport).to respond_to(:find).with(1).argument
    expect(Airport).to respond_to(:find).with(1).argument.and_keywords(:sort)

    aps = Airport.find("Zhukovsky")
    expect(aps).to_not be == nil
    expect(aps.class).to be == Array
  end

end

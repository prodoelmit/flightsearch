require 'net/http'
class Airport 
  attr_accessor :code, :name, :cityCode, :cityName, :countryCode, :countryName, :latitude, :longitude, :stateCode, :timeZone

  def initialize(obj = nil)

    unless obj.nil?
      self.code = obj["airportCode"]
      self.name = obj["airportName"]
      self.cityCode = obj["cityCode"]
      self.cityName = obj["cityName"]
      self.countryCode = obj["countryCode"]
      self.countryName = obj["countryName"]
      self.latitude = obj["latitude"]
      self.longitude = obj["longitude"]
      self.stateCode = obj["stateCode"]
      self.timeZone = obj["timeZone"]
    end

  end

  def self.find(query, sort: false)
    url = URI::HTTP.build(host: "node.locomote.com",
                          path: "/code-task/airports",
                          query: {q: query}.to_query
                         )
    response = Net::HTTP.get_response(url)
    response.is_a?(Net::HTTPSuccess) or return nil
    objs = JSON.parse(response.body) or return nil
    
    airports = objs.map {|o| Airport.new(o) }
    if sort
      return airports.sort_by do |a|
        arr = [a.cityName, a.code, a.name, a.cityCode]
        inds = arr.map {|s| s.index(/#{Regexp.quote(query)}/i) or 1000}
        inds
      end
    else
      return airports
    end
  end
end

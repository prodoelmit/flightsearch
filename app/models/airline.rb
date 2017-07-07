class Airline
  attr_accessor :code, :name

  def flights(date: , from: , to: )
    url = flights_query_url(date: date, from: from, to: to) or return nil

    response = Net::HTTP.get_response(url)
    response.is_a?(Net::HTTPSuccess) or return nil
    objs = JSON.parse(response.body) or return nil
  end


  def initialize(obj = nil)
    unless obj.nil?
      self.code = obj["code"]
      self.name = obj["name"]
    end
  end

  def flights_query_url(date: , from: , to: )
    unless date.is_a?(Date)
      begin 
        date = date.to_date
      rescue 
        return nil
      end
    end


    from_code = from.is_a?(Airport) ? from.code : from 
    to_code = to.is_a?(Airport) ? to.code : to 

    URI::HTTP.build(host: "node.locomote.com",
                    path: "/code-task/flight_search/#{code}",
                    query: {date: date,
                            from: from_code,
                            to: to_code
                    }.to_query
                   )
  end

  def self.all
    url = URI::HTTP.build( host: "node.locomote.com",
                          path: "/code-task/airlines",
                         )
    response = Net::HTTP.get_response(url)
    response.is_a?(Net::HTTPSuccess) or return nil
    objs = JSON.parse(response.body) or return nil
    
    objs.map {|o| Airline.new(o) }
  end
end

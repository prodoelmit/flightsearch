class Airline
  attr_accessor :code, :name

  def flights(date: , from: , to: )
    url = flights_query_url(date: date, from: from, to: to) or return nil
  end


  def initialize(obj = nil)
    unless obj.nil?
      self.code = obj[:code]
      self.name = obj[:name]
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


    (from.is_a?(Airport) and to.is_a?(Airport)) or return nil

    URI::HTTP.build(host: "node.locomote.com",
                    path: "/code-task/flight_search/#{code}",
                    query: {date: date,
                            from: from.code,
                            to: to.code
                    }.to_query
                   )
  end
end

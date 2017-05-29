require 'time'
require 'soda/client'



class FoodTrucksWrapper

  # Method calls the Food Trucks API and returns the response needed
  # day is weekday, as a string
  # time_of_day is the hour and minute of the day, as a string
  def self.get_food_trucks(day = Time.now.strftime("%u"), time_of_day = Time.now.strftime("%H:%M"))

    client = SODA::Client.new({:domain => "data.sfgov.org", :app_token => nil}) # request app token, if throttled

    results = client.get("bbb8-hzi6", {:$limit => 5000,
      :$where => "dayorder = '#{day}' AND '#{time_of_day}' BETWEEN start24 AND end24"})
  end

  def self.list_food_trucks(day = Time.now.strftime("%u"), time_of_day = Time.now.strftime("%H:%M"))
    api_response = FoodTrucksWrapper.get_food_trucks(day, time_of_day)
    result = []
    api_response.each do |item|
      vendor = {}
      vendor[:name] = item[:applicant]
      vendor[:address] = item[:location]
      result << vendor
    end
    return result
  end
end

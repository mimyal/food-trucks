require 'time'
require 'soda/client'



class FoodTrucksWrapper

  # Method calls the Food Trucks API and returns the response needed
  # day is weekday, as a string
  # time_of_day is the hour and minute of the day, as a string
  def self.get_food_trucks(day = Time.now.strftime("%u"), time_of_day = Time.now.strftime("%H:%M"))

    client = SODA::Client.new({:domain => "data.sfgov.org", :app_token => nil}) # request app token, if throttled

    results = client.get("bbb8-hzi6", :$limit => 5000)

    puts "Got #{results.count} results. Dumping first results:"

    puts results[10].applicant
    puts results[10].dayorder
    puts results[10].start24
    puts results[10].end24
    puts results[10].location

    # TDD from this point

  end
# {
#         "applicant": "Halal Cart, LLC",
#         "dayofweekstr": "Saturday",
#         "dayorder": "6",
#         "end24": "18:00",
#         "endtime": "6PM",
#         "location": "532 MARKET ST",
#         "start24": "06:00",
#         "starttime": "6AM",
#     }
end

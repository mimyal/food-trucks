require_relative 'food_trucks_wrapper.rb'

class FoodTrucksViewer

  def get_food_trucks(day, time_of_day)
    raise(ArgumentError, 'Day and Time for Food Trucks must be known') unless day && time_of_day
    vendors = FoodTrucksWrapper.get_food_trucks(day, time_of_day)

    response = []
    vendors.each do |vendor|
      if is_open?(vendor)
        response << vendor
      end
    end
    response.sort_by! { |vendor| vendor[:name] }
    return response
  end

  # Will return the an empty array, once all have been shown
  def view_food_trucks(vendors)
    n = 0
    while !vendors.empty? && vendors.length > n
      puts 'Do you want to view food trucks?'
      if get_action == 'y'
        # First code view ONE
        # View ten at the time
        vendors[n...n+10].each do |vendor|
          show_food_truck(vendor)
        end
        n += 10
      else
        return 'Thank you for viewing the food trucks'
      end
      more = 'more '
    end #while
    "Sorry, there are no #{more}food trucks to view"
  end

  def get_action
    gets.chomp!.downcase[0]
  end

  private

  def show_food_truck(vendor)
    puts "#{vendor[:name].ljust(25)} #{vendor[:address]}"
  end

  def is_open?(vendor)
    vendor[:open]
  end

  def alphabetic_response(vendors)
    vendors.sort_by { |vendor| vendor[:name] }
  end

end

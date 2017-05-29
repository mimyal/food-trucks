require_relative 'food_trucks_wrapper.rb'

class FoodTrucksViewer

  def get_food_trucks(day, time_of_day)
    raise(ArgumentError, 'Day and Time for Food Trucks must be known') unless day && time_of_day
    vendors = FoodTrucksWrapper.list_food_trucks(day, time_of_day)

    vendors.sort_by! { |vendor| vendor[:name] }
  end

  def view_food_trucks(day = Time.now.strftime("%u"), time_of_day = Time.now.strftime("%H:%M"))
    vendors = get_food_trucks(day, time_of_day)
    item_num = 0
    more = nil
    while !vendors.empty? && vendors.length > item_num
      puts "Do you want to view #{more}food trucks?"
      if get_action == 'y'
        vendors[item_num...item_num+10].each do |vendor|
          show_food_truck(vendor)
        end
        item_num += 10
      else
        return 'Thank you for using the food trucks application'
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
end

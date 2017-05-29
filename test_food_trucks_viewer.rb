require 'minitest/autorun'
require 'mocha/mini_test'
require_relative 'food_trucks_viewer'

class FoodTrucksViewerTest < Minitest::Test

  describe '#get_food_trucks' do
    # Input
    let(:day) { '3' }
    let(:time_of_day) { '12:00' }
    let(:output) { [ {
      name: 'Beta Beet Soup',
      address: 'Market Street, The Village',
      }, {
      name: 'Epsilon Bowl',
      address: 'Across the street',
        }, {
      name: 'Alfa Omega Foods',
      address: 'On That Corner',
        } ] }

    before(:each) do
      @viewer = FoodTrucksViewer.new
      FoodTrucksWrapper.stubs(:list_food_trucks).with(day, time_of_day).returns output

    end

    it 'should take input day to list food trucks' do
      day = nil
      proc  { @viewer.get_food_trucks(day, time_of_day) }.must_raise Exception
    end

    it 'should take input time_of_day to view food trucks' do
      time_of_day = nil
      proc  { @viewer.get_food_trucks(day, time_of_day) }.must_raise Exception
    end

    it 'should return output as an array of hash' do
      response = @viewer.get_food_trucks(day, time_of_day)
      response.must_be_instance_of Array
      response.first.must_be_instance_of Hash
    end

    it 'should list food trucks in alphabetic order' do
      expected_output = [
        { name: 'Alfa Omega Foods',
          address: 'On That Corner',
          }, {
          name: 'Beta Beet Soup',
          address: 'Market Street, The Village',
          }, {
          name: 'Epsilon Bowl',
          address: 'Across the street',
        }
      ]
      response = @viewer.get_food_trucks(day, time_of_day)
      response.must_equal expected_output
    end
  end

  describe '#view_food_trucks' do
    let(:day) { '2' }
    let(:time_of_day) { '12:00' }
    let(:vendors) { [ {
      name: 'Alfa Omega Foods',
      address: 'On That Corner',
      }, {
      name: 'Beta Beet Soup',
      address: 'Market Street, The Village',
      }, {
      name: 'Epsilon Bowl',
      address: 'Across the street',
      } ] }

    before(:each) do
      @viewer = FoodTrucksViewer.new
      @viewer.stubs(:get_action) { 'y' }
      @viewer.stubs(:get_food_trucks).returns vendors
    end

    it 'should take parameters day and time_of_day' do
      @viewer.view_food_trucks(day, time_of_day)
    end

    it 'should not fail if day and time_of_day are not given' do
      @viewer.view_food_trucks
    end

    it 'should call get_food_trucks' do
      @viewer.expects(:get_food_trucks).returns vendors
      @viewer.view_food_trucks
    end

    it 'should return return sorry if there are no vendors to show' do
      @viewer.stubs(:get_food_trucks).returns []
      @viewer.view_food_trucks(day, time_of_day).must_equal 'Sorry, there are no food trucks to view'
    end

    it 'should return thank you for viewing vendors while vendors' do
      @viewer.view_food_trucks.must_equal 'Thank you for using the food trucks application'
      @viewer.stubs(:get_action) { '' }
      @viewer.view_food_trucks.must_equal 'Thank you for using the food trucks application'
    end
  end
end

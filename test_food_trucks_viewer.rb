require 'minitest/autorun'
require 'mocha/test_unit'
require_relative 'food_trucks_viewer'

class FoodTrucksViewerTest < Minitest::Test

  describe '#get_food_trucks' do
    before(:each) do
      @viewer = FoodTrucksViewer.new
      FoodTrucksWrapper.stubs(:get_food_trucks).with(day, time_of_day).returns output
    end
    # Input
    let(:day) { 3 }
    let(:time_of_day) { 12 }
    let(:output) { [ {
      name: 'Beta Beet Soup',
      address: 'Market Street, The Village',
      open: true
      }, {
      name: 'Epsilon Bowl',
      address: 'Across the street',
      open: true
        }, {
      name: 'Alfa Omega Foods',
      address: 'On That Corner',
      open: false
        } ] }

    it 'should take input day to view food trucks' do
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

    it 'should list open food trucks only' do
      expected_output = [ {
        name: 'Beta Beet Soup',
        address: 'Market Street, The Village',
        open: true
        }, {
        name: 'Epsilon Bowl',
        address: 'Across the street',
        open: true
        } ]
      response = @viewer.get_food_trucks(day, time_of_day)
      response.must_equal expected_output
    end

    it 'should list food trucks in alphabetic order' do
      output.last[:open] = true

      expected_output = [
        { name: 'Alfa Omega Foods',
          address: 'On That Corner',
          open: true
          }, {
          name: 'Beta Beet Soup',
          address: 'Market Street, The Village',
          open: true
          }, {
          name: 'Epsilon Bowl',
          address: 'Across the street',
          open: true
        }
      ]
      response = @viewer.get_food_trucks(day, time_of_day)
      response.must_equal expected_output
    end
  end

  describe '#view_food_trucks' do
    before(:each) do
      @viewer = FoodTrucksViewer.new
      @viewer.stubs(:get_action) { 'y' }
    end
    let(:vendors) { [ {
      name: 'Alfa Omega Foods',
      address: 'On That Corner',
      open: true
      }, {
      name: 'Beta Beet Soup',
      address: 'Market Street, The Village',
      open: true
      }, {
      name: 'Epsilon Bowl',
      address: 'Across the street',
      open: true
      } ] }

    it 'should return return sorry if there are no vendors to show' do
      vendors = []
      @viewer.view_food_trucks(vendors).must_equal 'Sorry, there are no food trucks to view'
    end

    it 'should return thank you for viewing vendors while vendors' do
      @viewer.view_food_trucks(vendors).must_equal 'Thank you for viewing the food trucks'
      @viewer.stubs(:get_action) { '' }
      @viewer.view_food_trucks(vendors).must_equal 'Thank you for viewing the food trucks'
    end
  end

end

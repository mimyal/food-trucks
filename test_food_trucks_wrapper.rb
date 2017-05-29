require 'minitest/autorun'
require 'mocha/mini_test'
require_relative 'food_trucks_wrapper.rb'

class FoodTrucksWrapperTest < Minitest::Test

  describe '#get_food_trucks' do
    let(:day) { '2' }
    let(:time_of_day) { '12:00' }
    let(:api_response) { [
      {
        ":@computed_region_ajp5_b2md": "8",
        ":@computed_region_bh8s_q3mv": "28860",
        ":@computed_region_jx4q_fizf": "2",
        ":@computed_region_rxqg_mtj9": "9",
        ":@computed_region_yftq_j783": "4",
        "addr_date_create": "2016-08-01T14:11:15.000",
        "addr_date_modified": "2017-02-08T17:12:36.000",
        "applicant": "Halal Cart, LLC",
        "block": "0266",
        "cnn": "8741101",
        "coldtruck": "N",
        "dayofweekstr": "Tuesday",
        "dayorder": "2",
        "end24": "18:00",
        "endtime": "6PM",
        "latitude": "37.791693660724746",
        "location": "1 FRONT ST",
        "location_2": {
            "type": "Point",
            "coordinates": [
                -122.398334,
                37.791694
            ] },
        "locationdesc": "Push cart on Market St, between Front and Bush, approx. 45ft west of Front",
        "locationid": "834748",
        "longitude": "-122.39833403978321",
        "lot": "009",
        "optionaltext": "Chicken; Lamb; Kabobs; Rice",
        "permit": "16MFF-0129",
        "start24": "06:00",
        "starttime": "6AM",
        "x": "6013168.38406",
        "y": "2116298.68582"
    } ] }
    before(:each) do
      @client = mock
      SODA::Client.stubs(:new).with({:domain => "data.sfgov.org", :app_token => nil}).returns @client
      @client.stubs(:get).returns api_response
    end

    it 'should take parameters day and time_of_day' do
      FoodTrucksWrapper.get_food_trucks(day, time_of_day).must_equal api_response
    end

    it 'should not fail if day and time_of_day are not given' do
      FoodTrucksWrapper.get_food_trucks.must_equal api_response
    end

    it 'should call the Food Trucks API' do
      SODA::Client.expects(:new).with({:domain => "data.sfgov.org", :app_token => nil}).returns @client
      FoodTrucksWrapper.get_food_trucks
    end

    it 'should return an array of hash' do
      FoodTrucksWrapper.get_food_trucks.must_be_instance_of Array
      FoodTrucksWrapper.get_food_trucks.first.must_be_instance_of Hash
    end
  end

  describe '#list_food_trucks' do
    let(:day) { '2' }
    let(:time_of_day) { '12:00' }
    let(:api_response) { [ {
      "applicant": "Alpha Beta Cart",
      "location": "Market Street",
      "another-response-value": "unimportant information"
      } ] }
    let(:result) { [ {
      name: 'Alpha Beta Cart',
      address: 'Market Street'
      } ] }
    before(:each) do
      FoodTrucksWrapper.stubs(:get_food_trucks).returns api_response
    end

    it 'should take parameters day and time_of_day' do
      FoodTrucksWrapper.list_food_trucks(day, time_of_day).must_equal result
    end

    it 'should not fail if day and time_of_day are not given' do
      FoodTrucksWrapper.list_food_trucks.must_equal result
    end

    it 'should call get food trucks method' do
      FoodTrucksWrapper.expects(:get_food_trucks).returns api_response
      FoodTrucksWrapper.list_food_trucks
    end

    it 'should return an empty array if api_response is empty' do
      FoodTrucksWrapper.stubs(:get_food_trucks).returns []
      FoodTrucksWrapper.list_food_trucks.must_equal []
    end

    it 'should list food trucks as expected' do
      FoodTrucksWrapper.stubs(:get_food_trucks).returns api_response
      FoodTrucksWrapper.list_food_trucks(day, time_of_day).must_equal result
    end

  end
end

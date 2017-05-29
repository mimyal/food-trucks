# Open Food Trucks Application

## What it does
This application will list currently open food trucks in San Francisco.  

## This implementation
* The City of San Francisco Food Trucks API is called from the wrapper class FoodTrucksWrapper.  

* The wrapper is directed by the FoodTruckViewer class, which also prints out the information to the terminal.  

## Dependencies
Use command line 'bundle install' before running this application. It was developed using Ruby 2.3.1. 
These are the gems needed:  
	* Minitest  
	* Mocha  
	* Soda  
	* Soda-ruby  

## How to run it
Clone this GitHub project to your computer. Have Ruby and the gems installed. Run the application from the command line, in the same directory as where it was cloned:  
<center><strong>ruby food_trucks.rb</strong></center>   

## Limitations
* Running this application outside San Francisco timezone will yield invalid results.    
* API calls have no integration tests. Calls are assumed valid. The application does not handle failed API calls.  
* The application was not tested for edge cases, such as what happens if there are ten results exactly, or none.  
* Given more time, structural improvements, such as replacing parameters day and time_of_day with a datetime object would be implemented.  

## Future improvements
This application will only show listings for current time. As it was developed to search for other days and times it would take very little to list any range of time as needed.

## Website development
If the goal is to list current open food trucks for anyone to use, the website should limit the number of calls to the external API by caching its results for one minute or up to the half hour after it has been called.   

I see the opportunity to make a mobile-friendly website to show location on a map, using API data and third party maps.  

Alphabetic order is not useful for this application's users, distance would be a better sorting mechanism. A simple upgrade if this was implemented would be to link each address in its website table to a map.

An additional feature to list 'today's listing' within walking-distance would provide both a reason to explore and directions to the users.   
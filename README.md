William & Mary Maintenance Request App
======================================

This is the github repository for our Software Engineering class project.

To get this working, just clone the repo and run bundle install --without production 
Then rails s will load the site 

To get the database populated with buildings (in case it gets wiped or anything like that), there is a script in /scripts called addBuildings script. Load the console with "rails c" and then run the command "load("scripts/addBuildingScript.rb")"

Initial admin has credentials:
admin@example.com
password

William & Mary Maintenance Request App
======================================

This is the github repository for our Software Engineering class project.

To get this working, just clone the repo and run bundle install --without production 
Then rails s will load the site 

To get the database populated with buildings (in case it gets wiped or anything like that), there is a script in /scripts called addBuildings script. Load the console with "rails c" and then run the command "load 'addBuildingScript.rb'"(don't include double quotes). To load buildings on heroku deployment (currently http://sheltered-harbor-6221.herokuapp.com), just type "heroku run rails c" first to access the console 

Initial admin has credentials:
admin@example.com
password



====================Scrolling Fixed ======================

1. Made a small change to appliation.html.erb that allowed scrolling (entire page isn't attached to navbar).
2. Had to move a line "config.time_zone = 'Eastern Time (US & Canada)'" in the file config/environment.rb to config/environments/development.rb because I couldn't migrate the database otherwise.


William & Mary Maintenance Request App
======================================

This is the github repository for our Software Engineering class project.

To get this working, just clone the repo and run bundle install --without production 
Then rails s will load the site 

To get the database populated with buildings (in case it gets wiped or anything like that), there is a script in /scripts called addBuildings script. Load the console with "rails c" and then run the command "load 'addBuildingScript.rb'"(don't include double quotes). To load buildings on heroku deployment (currently http://sheltered-harbor-6221.herokuapp.com), just type "heroku run rails c" first to access the console 

Initial admin has credentials:
admin@example.com
password


=======Assigning Workers Branch=============


1.  Implemented WorkorderRelationship.rb which will represent the state of a worker being assigned to a workorder
2.  Made it so that when a WorkorderRelationship is created, destroyed, updated the name of the worker will be changed on the workorder


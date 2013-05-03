William & Mary Maintenance Request App
======================================

This is the github repository for our Software Engineering class project.

To get this working, just clone the repo and run bundle install --without production 
Then rails s will load the site 

To get the database populated with buildings (in case it gets wiped or anything like that), there is a script in /scripts called addBuildings script. Load the console with "rails c" and then run the command "load 'addBuildingScript.rb'"(don't include double quotes). To load buildings on heroku deployment (currently http://sheltered-harbor-6221.herokuapp.com), just type "heroku run rails c" first to access the console 

Initial admin has credentials:
admin@example.com
password



====================Implementing Ratings Branch======================


Changes in this branch are predicated on the idea that "Closed" is the final state for a workorder.

Summary of changes:

1. Made a workorder review form for the user, the link for which shows up under a resolved workorder
2. Added total_workorders_completed and average_workorder_rating columns to the worker model--need rake db:migrate.
   When a new worker is created these values are set to 0 by default. 
   Also, since these attributes will initially be undefined for existing workers values of 0 may have to be made 
   manually in the console for all workers, something like:
   
			Worker.all.each do |worker|
			    worker.update_attributes(average_workorder_rating: 0.0)
			    worker.update_attributes(total_workorders_completed: 0)
			  end

3. Made it so that all closed workorders show up on their own page. 
4. Created new links in the navbar for both users and workers to show their completed workorders. 
   Accordingly, this involved making changes to routes.rb.  
5. Made it so that users can't add comments/updates to a closed workorder--simple if-else in workorders/show.html.erb
6. Made the worker stat page display the worker average
7. Had to add another migration as a workaround for the fact that work orders can 
   be closed by both admins and users--only want ratings to show up for users.









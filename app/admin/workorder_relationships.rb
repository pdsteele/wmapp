ActiveAdmin.register WorkorderRelationship do
    controller { with_role :admin }
    
        menu :label => "Assignments" # more descriptive than "Workorder Relationships"

    
    
    ##
    # ActiveAdmin uses the InheritedResources gem( see http://railscasts.com/episodes/230-inherited-resources 
    # or https://github.com/josevalim/inherited_resources).  This means that the new, show, update, etc resource
    # actions don't have to be explicitly stated in the controller.  We can override this funtionality by 
    # explicitly listing them in a block that is passed to "controller".  This allows us to do special
    # actions before and after the RESTful operation is performed.  We are interested in updating 
    # the "worker" and "state" attributes of workorder after a WorkorderRelation ship is created, 
    # updated, and destroyed
    ##
    
    
    controller do
	  def create #do |new_workorder_relationship|

		create!
		
		# everything down here is done after the workorder is created--note that @workorder is defined
		# in the default create action provided by InheritedResources
		
		
		# what this (hideous)line is supposed to be doing: finding the workorder that was just assigned
		# and setting its "worker" attribute to the name person to whom it was assigned
		Workorder.find_by_id(@workorder_relationship.workorder_id).update_attributes(:worker => Worker.find_by_id(@workorder_relationship.worker_id)[:name])
	  end
	end
	
	 controller do
	  def destroy

		destroy! do |workorder_relationship|
		
		  Workorder.find_by_id(@workorder_relationship.workorder_id).update_attributes(:worker => "None")
		end
	  end
	end
	
	
	controller do
	  def update #do |new_workorder_relationship|

		update!
		
		Workorder.find_by_id(@workorder_relationship.workorder_id).update_attributes(:worker => Worker.find_by_id(@workorder_relationship.worker_id)[:name])
	  end
	end


	                     


 form do |f|                         
    f.inputs :title => "Assignment Details"       
#       f.input :worker
#       f.input :description#, :as => :select,  :collection => Workorder.all
     #end                               
     f.actions                         
   end  
    
    index do
		column :id                     
		column :worker_id
		column :workorder_id
		
		column "Worker Name" do |workorder_relationship|
			Worker.find_by_id(workorder_relationship.worker_id)[:name]
		end
		
		column "Requestor" do |workorder_relationship|
			#this could be refactored at some point :}
			User.find_by_id( Workorder.find_by_id(workorder_relationship.workorder_id).user_id)[:name]
		end
			
		default_actions                   
    end         
    
    
    show do |ad|
      attributes_table do
        row :workorder_id
        row :worker_id 
      end
      active_admin_comments
    end


end

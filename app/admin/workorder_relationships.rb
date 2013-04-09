ActiveAdmin.register WorkorderRelationship do
    controller { with_role :admin }
    
    
    
    index do
		puts( "THE id", WorkorderRelationship.find_by_worker_id(:worker_id) )
		puts("----------------------")
		puts( "#{@worker}" )
		puts("--------------------")
    	#end
		column :id                     
		column :worker_id
		column :workorder_id
		
		column "Worker Name" do |workorder_relationship|
			Worker.find_by_id(workorder_relationship.worker_id)[:name]
		end
		
		column "Requestor" do |workorder_relationship|
			#this should be refactored at some point :}
			User.find_by_id( Workorder.find_by_id(workorder_relationship.workorder_id).user_id)[:name]
		end
			
			
			
		#column "Description"
		#puts(@worker[:name])
		# if :worker_id.nil? == false
# 			column @worker[:name]
# 		end
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

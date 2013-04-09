ActiveAdmin.register WorkorderRelationship do
    controller { with_role :admin }
    
    
    
    index do
		# @worker = Worker.find_by_id(:worker_id)
# 		puts( "THE id", :worker_id )
# 		puts( @worker )
    	#end
		column :id                     
		column :worker_id        
		column :workorder_id
		# column "Worker Name" do |worker_name|
# 			worker_name.find_by_id(params[:worker_id])
# 			end
			
		#column "Worker Name", @worker[:name]
			
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

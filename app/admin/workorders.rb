ActiveAdmin.register Workorder do
    controller { with_role :admin }  
    
   #scope :all
   scope :pending
   scope :in_progress
   scope :completed  
   
   
  #  sidebar "Project Details" do
#    	ul do
#    	  li link_to("Assign", admin_project_assign_path(Workorder))
# 	end
#    end
   
    #  batch_action :assign do |selection|
# 	 	 link_to("Assign", admin_project_assign_path(Workorder))
#      end
    
end


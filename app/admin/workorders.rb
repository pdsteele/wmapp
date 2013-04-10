


ActiveAdmin.register Workorder do
    controller { with_role :admin }  
    
   #scope :all
   scope :pending
   scope :in_progress
   scope :completed  
   
   
   form do |f|
      f.inputs "Workorder Details" do
        f.input :user, :collection => User.order("name ASC").all.map{ |user| [user.name] }
        f.input :building, :collection => Buildings.order("name ASC").all.map{ |building| [building.name] } 
        f.input :room
        f.input :description
      end
      f.buttons
    end
   
    # batch_action :assign do |selection|
#       Workorder.find(selection).each do |post|
#         post.flag! :hot
#       end
#     end
  
    
end


# ActiveAdmin.register Workorder do
#     controller { with_role :admin }  
#     
#    actions :index, :show 
#    #scope :all
#    scope :pending
#    scope :in_progress
#    scope :completed  
#    
#    
#    
#   #  index do
# #     actions do |workorder|
# #     	link_to "Assign "
# #   end
#    
#    show do |ad|
#       attributes_table do
#         row :id
#         row :description 
#         row :building
#         row :room
#         row :worker
#         row :state
#       end
#       
#       controller do 
#       	def workers
#       		Worker.all
#       	end
#       	panel "Assign" do
#          table_for(workers) do |t|
#          t.column("Building")     {|item|  item.building        }
#          t.column("Description")  {|item|  item.description     }
#         end
#       end
#       
#       active_admin_comments
#     end
#    end
  # show do
#     panel "Assign" do
#        table_for(workorder.attribu) do |t|
# #         t.column("Building")     {|item|  item.building        }
# #         t.column("Description")  {|item|  item.description     }
#        end
#     end
#   end
   		
   		
   	# show do
#     panel "Assign" do
#       table_for(order.line_items) do |t|
#         t.column("Product") {|item| auto_link item.product        }
#         t.column("Price")   {|item| number_to_currency item.price }
#         tr :class => "odd" do
#           td "Total:", :style => "text-align: right;"
#           td number_to_currency(order.total_price)
#         end
#       end
#     end
   		
   
 #  sidebar "Project Details" do
#    	ul do
#     	  li link_to("Assign", admin_project_assignments_path())
#  	end
#  	end
   
   # batch_action :assign do |selection|
# 	 	 link_to("Assign", admin_project_assign_path(Workorder))
#      end
    
#end


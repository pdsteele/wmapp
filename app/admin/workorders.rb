ActiveAdmin.register Workorder do
    controller { with_role :admin } 

    #show page override 
    show do
      @workorder = Workorder.find(params[:id])
      @worklog = @workorder.worklogs.new(params[:worklog])
      @worklogs_visible = @workorder.worklogs.all

      #render 'show'

      panel "Workorder Details" do
        attributes_table_for @workorder do 
          row("User Name") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
          row("User Email") { |workorder| workorder.user.email } 
          row("User Phone") { |workorder| workorder.user.phone }
          row("Building") { |workorder| workorder.building }
          row("Room") { |workorder| workorder.room }
          row("State") { |workorder| workorder.state }
          row("Worker") { |workorder| workorder.worker ? workorder.worker : 'NONE' } 
          row("User Description") { |workorder| workorder.description }
          row("Last Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
          row("Originally Created") { |workorder| time_ago_in_words(workorder.created_at)+" ago" }
        end#end table
      end #end panel 

      

      panel "New Comment/Update" do
        render 'form'
      end


      #show worker stats panel if assigning
      if (@worklogs_visible.first.state == 'Pending' or @worklogs_visible.first.state == 'Deferred' or @worklogs_visible.first.state == 'Reopened')
        panel "Worker Stats" do
          table_for Worker.all do |t|
            t.column("Name") { |worker| link_to worker.name, admin_worker_path(worker.id) }
            t.column("Number of Currently Assigned Workorders") { |worker| Workorder.where(:worker_id => worker.id, :state => "Assigned").size }
            t.column("Number of Workorders In Progress") { |worker| Workorder.where(:worker_id => worker.id, :state => "In Progress").size }
            t.column("Workorders Completed in Last Month") { |worker| Workorder.where(:worker_id => worker.id, :state => "Resolved").size + Workorder.where(:worker_id => worker.id, :state => "Closed").find(:all, :conditions => ["created_at > ?", 30.days.ago]).size }
            t.column("Workorders Reopened in Last Month") {|worker| Worklog.where(:worker_id => worker.id, :state => "Reopened").find(:all, :conditions => ["created_at > ?", 30.days.ago]).size }
          end #end table
        end #end panel
      end #end if

      panel "Comments and Updates" do
        table_for @worklogs_visible do |t|
          t.column("Author") { |worklog| worklog.name }
          t.column("Date Created") { |worklog| worklog.created_at.strftime("%b. %d %Y   %I:%M %p") }
          t.column("Assigned Worker") { |worklog| worklog.worker ? worklog.worker.name : 'N/A' }
          t.column("State") {|worklog| worklog.state }
          t.column("Comment/Update") { |worklog| worklog.description }
          t.column("Hidden From User") { |worklog| status_tag (worklog.fac_man_only ? "true" : "false"), (worklog.fac_man_only ? :error : :ok) }
          t.column("High Priority") { |worklog| status_tag (worklog.unsolicited ? "true" : "false"), (worklog.unsolicited ? :error : :ok) }
          t.column("Mark as Read/Low Priority") { |worklog| link_to "Mark as Read/Low Priority", respond_to_comment_path(worklog.workorder.id, worklog.id) }
          t.column("Delete Update") { |worklog| link_to "Delete", admin_workorder_worklog_path(worklog.workorder_id, worklog), :method => :delete, :data => {:confirm => "Are you sure?"} }
        end #end table
      end #end panel

    end #end show override 

    # This form is for creating a new workorder 
    form do |f|
      f.inputs "Workorder Details" do
        f.input :user, :collection => User.order("name ASC").all.map{ |user| [user.name, user.id] }
        f.input :building, :collection => Buildings.order("name ASC").all.map{ |building| [building.name] } 
        f.input :room
        f.input :worker, :collection => Worker.order("name ASC").all.map{ |worker| [worker.name, worker.id] }
        f.input :state, :collection => ['Pending', 'Assigned', 'In Progress', 'Deferred', 'Resolved', 'Closed']
        f.input :description
      end
      f.buttons
    end

    # CONTROLLER OVERRIDES
    controller do

      def assign_workorder
        # Page for assigning a workorder and creating worklog necessary for it 
        @workorder = Workorder.find(params[:workorder_id])
        @worklog = @workorder.worklogs.new(params[:worklog])
        #@worklog.name = current_admin_user.email
      end

      def close_workorder 
        # page for resolving a workorder and creating worklog necessary
        @workorder = Workorder.find(params[:id])
        @worklog = @workorder.worklogs.new(params[:worklog])
        @worklogs_visible = @workorder.worklogs.all

        # creating closed worklog 
        @worklog.name = "Administrator"
        @worklog.state = "Closed"
        @worklog.description = "Workorder has been resolved and inactive for some time, so it has been closed. Please submit a new workorder for new issues."
        @worklog.fac_man_only = false
        @worklog.unsolicited = false 
        @worklog.worker_id = @workorder.worker_id
        @worklog.worker = @workorder.worker

        if @worklog.save
          flash[:success] = "Workorder has been closed!"
        end #end if

        redirect_to admin_workorder_path(@workorder)

      end #end function 

      def respond_to_comment
        # page to respond to high priority comment and automatically change its unsolicited bool to false 
        @workorder = Workorder.find(params[:id])
        @worklog = @workorder.worklogs.new(params[:worklog])
        @worklogs_visible = @workorder.worklogs.all
        @unsolicitedworklog = @workorder.worklogs.find(params[:worklog_id])

        @unsolicitedworklog.unsolicited = false

        if @unsolicitedworklog.save
          flash[:success] = "Comment marked as low priority!"
        end

        redirect_to admin_workorder_path(@workorder)
      end

    end #end controller overrides 

    
   actions :index, :show, :new, :destroy
   scope :all
   scope :pending
   scope :in_progress
   scope :reopened
   scope :deferred
   scope :resolved
   scope :closed
   
   
   
  #  index do
#     actions do |workorder|
#     	link_to "Assign "
#   end
   
   # show do |ad|
   #    attributes_table do
   #      row :id
   #      row :user_id
   #      row :description 
   #      row :building
   #      row :room
   #      row :worker_id
   #      row :state
   #    end
      
   #    controller do 
   #    	def workers
   #    		Worker.all
   #    	end
   #    	panel "Assign" do
   #       table_for(workers) do |t|
   #       t.column("Building")     {|item|  item.building        }
   #       t.column("Description")  {|item|  item.description     }
   #      end
   #    end
      
   #    active_admin_comments
   #  end
   # end


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
    
end


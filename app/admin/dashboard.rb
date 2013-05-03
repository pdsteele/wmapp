ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  #ActiveAdmin::Dashboards.build do

  content :title => proc{ I18n.t("active_admin.dashboard") } do

  columns do #new row
    column do #new column
      panel "Recent High Priority Comments/Updates" do 
        table_for Worklog.where(:unsolicited => true).find(:all, :conditions => ["created_at > ?", 7.days.ago]) do |t|
          t.column("Created") { |worklog| time_ago_in_words(worklog.created_at)+" ago" }
          t.column("Workorder Last Updated") { |worklog| time_ago_in_words(worklog.workorder.updated_at)+" ago" }
          t.column("Author") { |worklog| worklog.name }
          t.column("User Email") { |worklog| User.where(:id => worklog.workorder.user_id).first.email }
          t.column("User Phone") { |worklog| User.where(:id => worklog.workorder.user_id).first.phone }
          t.column("Building") { |worklog| worklog.workorder.building }
          t.column("Room Number") { |worklog| worklog.workorder.room }
          t.column("Workorder Description") { |worklog| worklog.workorder.description }
          t.column("Comment/Update") { |worklog| worklog.description }
          t.column("Reply and Keep High Priority") { |worklog| link_to "Reply", admin_workorder_path(worklog.workorder.id) }
          t.column("Reply and Mark as Low Priority") { |worklog| link_to "Reply and Mark as Low Priority", respond_to_comment_path(worklog.workorder.id, worklog.id) }
        end #end table
      end #end panel
    end #end column
  end #end row

  columns do #starts a row 
    
    column do #starts column in this row 
      panel "Unassigned Workorders" do
        table_for Workorder.where(:worker_id => nil) do |t|
          t.column("Created") { |workorder| time_ago_in_words(workorder.created_at)+" ago" }
          t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
          t.column("Building") { |workorder| workorder.building }
          t.column("Room Number") { |workorder| workorder.room }
          t.column("Description") { |workorder| workorder.description }
          #t.column("Workers") { :collection => Worker.all.map(&:name) }
          t.column("Assignment") { |workorder| link_to "Assign Workorder", admin_workorder_path(workorder.id) }
        end #end table
      end #end panel
    end #end column
  end # end row

  columns do #new row 
    column do 
      panel "Deferred Workorders" do
        table_for Workorder.where(:state => 'Deferred') do |t|
          t.column("Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
          t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
          t.column("Original Worker") { |workorder| link_to Worker.where(:id => workorder.worker_id).first.name, admin_worker_path(workorder.worker_id) }
          t.column("Reason Deferred") { |workorder| workorder.worklogs.where(:state => "Deferred").first.description }
          
          #what happens in above line if there are no deferred states?
          
          t.column("Building") { |workorder| workorder.building }
          t.column("Room Number") { |workorder| workorder.room }
          t.column("Description") { |workorder| workorder.description }
          t.column("Assignment") { |workorder| link_to "Re-assign Workorder", admin_workorder_path(workorder.id) }
        end #end table
      end #end panel
    end #end column

  end #ends row

  columns do #new row
    column do 
      panel "Worker Stats" do
        table_for Worker.all do |t|
            t.column("Name") { |worker| link_to worker.name, admin_worker_path(worker.id) }
            t.column("Number of Currently Assigned Workorders") { |worker| Workorder.where(:worker_id => worker.id, :state => "Assigned").size }
            t.column("Number of Workorders In Progress") { |worker| Workorder.where(:worker_id => worker.id, :state => "In Progress").size }
            t.column("Workorders Completed in Last Month") { |worker| Workorder.where(:worker_id => worker.id, :state => "Resolved").size + Workorder.where(:worker_id => worker.id, :state => "Closed").find(:all, :conditions => ["created_at > ?", 30.days.ago]).size }
            t.column("Workorders Reopened in Last Month") {|worker| Worklog.where(:worker_id => worker.id, :state => "Reopened").find(:all, :conditions => ["created_at > ?", 30.days.ago]).size }
            t.column("Overall Rating" ){|worker| worker.average_workorder_rating.round(2)}
        end #end table
      end #end panel
    end #end column
  end #end row

  columns do #new row
    column do #new column
      panel "Reopened" do #Not high priority for admins, but if they see the same workorder reopen several times, they can reassign it to someone else 
        table_for Workorder.where(:state => 'Reopened') do |t|
          t.column("Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
          t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
          t.column("Email") { |workorder| User.where(:id => workorder.user_id).first.email }
          t.column("Phone") { |workorder| User.where(:id => workorder.user_id).first.phone }
          t.column("Building") { |workorder| workorder.building }
          t.column("Room Number") { |workorder| workorder.room }
          t.column("Description") { |workorder| workorder.description }
          t.column("Assignment") { |workorder| link_to "Re-assign Workorder", admin_workorder_path(workorder.id) }
        end
      end #end panel
    end #end column
  end #end row

  columns do #new row
    column do #new column
      panel "Inactive Resolved Workorders" do
        table_for Workorder.where(:state => 'Resolved').find(:all, :conditions => ["updated_at <= ?", 2.days.ago]) do |t| #shows resolved workorders that haven't been touched in at least 2 days
          t.column("Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
          t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
          t.column("Email") { |workorder| User.where(:id => workorder.user_id).first.email }
          t.column("Phone") { |workorder| User.where(:id => workorder.user_id).first.phone }
          t.column("Worker") { |workorder| workorder.worker ? (link_to workorder.worker.name, admin_worker_path(workorder.worker_id)) : 'NONE' }
          t.column("Building") { |workorder| workorder.building }
          t.column("Room Number") { |workorder| workorder.room }
          t.column("Description") { |workorder| workorder.description }
          t.column("Work Completed") { |workorder| workorder.worklogs.where(:state => "Resolved").first.description }
          t.column("Assignment") { |workorder| link_to "Close Workorder", close_workorder_path(workorder.id) }
        end #end table
      end #end panel
    end #end column
  end #end row

  

end #end content
end #end page

ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }


  #uses older dashboard style - will be deprecated in next version - remove line in active admin stylesheet when upgrading 

  ActiveAdmin::Dashboards.build do
  
  section "Resolved Workorders" do
    table_for Workorder.where(:state => 'Resolved') do |t|
      t.column("Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
      #t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
      t.column("Email") { |workorder| User.where(:id => workorder.user_id).first.email }
      t.column("Phone") { |workorder| User.where(:id => workorder.user_id).first.phone }
      #t.column("Worker") { |workorder| link_to Worker.where(:id => workorder.worker_id).first.name, admin_worker_path(workorder.user_id) }
      t.column("Building") { |workorder| workorder.building }
      t.column("Room Number") { |workorder| workorder.room }
      t.column("Description") { |workorder| workorder.description }
      t.column("Assignment") { |workorder| link_to "Close Workorder", edit_admin_workorder_path(workorder.id) }
    end
  end


  section "Deferred Workorders" do
    table_for Workorder.where(:state => 'Deferred') do |t|
      t.column("Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
      #t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
      t.column("Email") { |workorder| User.where(:id => workorder.user_id).first.email }
      t.column("Phone") { |workorder| User.where(:id => workorder.user_id).first.phone }
      #t.column("Worker") { |workorder| link_to Worker.where(:id => workorder.worker_id).first.name, admin_worker_path(workorder.user_id) }
      t.column("Building") { |workorder| workorder.building }
      t.column("Room Number") { |workorder| workorder.room }
      t.column("Description") { |workorder| workorder.description }
      t.column("Assignment") { |workorder| link_to "Re-assign Workorder", edit_admin_workorder_path(workorder.id) }
    end
  end



  section "Worker Stats" do
    table_for Worker.all do |t|
      #t.column("Name") { |worker| link_to worker.name, admin_worker_path(worker.id) }
      t.column("Number of Currently Assigned Workorders") { |worker| Workorder.where(:worker_id => worker.id, :state => "Assigned").size + Workorder.where(:worker_id => worker.id, :state => "In Progress").size }
      t.column("Workorders Completed To Date") { |worker| Workorder.where(:worker_id => worker.id, :state => "Resolved").size + Workorder.where(:worker_id => worker.id, :state => "Closed").size }
    end
  end 

  section "Unassigned Workorders" do
    table_for Workorder.where(:state => 'Pending') do |t|
      t.column("Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
      #t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
      t.column("Email") { |workorder| User.where(:id => workorder.user_id).first.email }
      t.column("Phone") { |workorder| User.where(:id => workorder.user_id).first.phone }
      t.column("Building") { |workorder| workorder.building }
      t.column("Room Number") { |workorder| workorder.room }
      t.column("Description") { |workorder| workorder.description }
      t.column("Assignment") { |workorder| link_to "Assign Workorder", edit_admin_workorder_path(workorder.id) }
    end
  end
end



  #show deferred workorders

  #show workorders assigned to each worker 

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

end

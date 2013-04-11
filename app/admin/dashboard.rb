ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }


  #show unassigned workorders 
  ActiveAdmin::Dashboards.build do
  section "Unassigned Workorders" do
    table_for Workorder.where(:state => 'Pending') do |t|
      t.column("Created") { |workorder| time_ago_in_words(workorder.created_at)+" ago" }
      t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
      t.column("Email") { |workorder| User.where(:id => workorder.user_id).first.email }
      t.column("Phone") { |workorder| User.where(:id => workorder.user_id).first.phone }
      t.column("Building") { |workorder| workorder.building }
      t.column("Room Number") { |workorder| workorder.room }
      t.column("Description") { |workorder| workorder.description }
      t.column("Assignment") { |workorder| t.select(workorder.worker, :collection => Worker.order("name ASC").all.map{ |worker| [worker.name] }) }
      #t.column("Assignment") { |workorder| t.select(workorder.worker, options_for_select(Worker.all.map(&:name))) }
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
  end # content
end

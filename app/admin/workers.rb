ActiveAdmin.register Worker do

    controller { with_role :admin }

    form do |f|
      f.inputs "Worker Details" do
        f.input :name
        f.input :email
        f.input :phone
        f.input :password
        f.input :password_confirmation
      end
      f.buttons
    end


    index do
      column :id
      column :name
      column :email
      column :phone
      column :total_workorders_completed
      column :average_workorder_rating
      default_actions
    end

    show do
        @worker = Worker.find(params[:id])
        @worker_workorders = @worker.workorders.all
        @worker_worklogs = @worker.worklogs.all

        panel "Worker Details" do
            attributes_table_for @worker do 
              row("Name") { |worker| worker.name }
              row("Email") { |worker| worker.email }
              row("Phone") { |worker| worker.phone }
              row("Workorders Currently Assigned") { |worker| worker.workorders.where(:state => "Assigned").size }
              row("Workorders Currently in Progress") { |worker| worker.workorders.where(:state => "In Progress").size }
              row("Workorders Deferred To Date") { |worker| worker.worklogs.where(:state => "Deferred").size }
              row("Workorders Completed To Date") { |worker| worker.workorders.where(:state => ['Resolved', 'Closed']).size }
            end #end table
        end #end panel

        panel "Worker Workorders" do
            table_for @worker_workorders do |t|
                t.column("Created") { |workorder| time_ago_in_words(workorder.created_at)+" ago" }
                t.column("Last Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
                t.column("State") { |workorder| workorder.state }
                t.column("Worker") { |workorder| link_to workorder.worker.name, admin_worker_path(workorder.worker_id) }
                t.column("Description") { |workorder| workorder.description }
                t.column("Link") { |workorder| link_to "Show Workorder", admin_workorder_path(workorder.id) }
            end #end table 
        end #end panel 

        panel "Worker Updates/Comments" do
            table_for @worker_worklogs do |t|
              t.column("Created") { |worklog| time_ago_in_words(worklog.created_at)+" ago" }
              t.column("Author") { |worklog| worklog.name }
              t.column("State") { |worklog| worklog.state }
              t.column("Hidden from Users?") { |worklog| status_tag (worklog.fac_man_only ? "true" : "false"), (worklog.fac_man_only ? :error : :ok) }
              t.column("High Priority?") { |worklog| status_tag (worklog.unsolicited ? "true" : "false"), (worklog.unsolicited ? :error : :ok) }
              t.column("Description") { |worklog| worklog.description }
              t.column("Link") { |worklog| link_to "Show Workorder", admin_workorder_path(worklog.workorder_id) }
            end #end table
        end #end panel 
    end #end show override

end

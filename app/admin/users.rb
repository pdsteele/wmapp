ActiveAdmin.register User do
    
    controller { with_role :admin }

    form do |f|
      f.inputs "User Details" do
        f.input :name
        f.input :email
        f.input :phone
        f.input :bannerID
        f.input :dorm, :collection => Buildings.order("name ASC").all.map{ |building| [building.name] } 
        f.input :room
        f.input :password
        f.input :password_confirmation
      end
      f.buttons
    end

    show do
        @user = User.find(params[:id])
        @user_workorders = @user.workorders.all

        panel "User Details" do
            attributes_table_for @user do 
              row("Name") { |user| user.name }
              row("Email") { |user| user.email }
              row("Phone") { |user| user.phone }
              row("Banner ID") { |user| user.bannerID }
              row("Building") { |user| user.dorm }
              row("Room") { |user| user.room }
            end #end table
        end #end panel

        panel "User Workorders" do
            table_for @user_workorders do |t|
                t.column("Created") { |workorder| time_ago_in_words(workorder.created_at)+" ago" }
                t.column("Last Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
                t.column("State") { |workorder| workorder.state }
                t.column("Worker") { |workorder| link_to workorder.worker.name, admin_worker_path(workorder.worker_id) }
                t.column("Description") { |workorder| workorder.description }
                t.column("Link") { |workorder| link_to "Show Workorder", admin_workorder_path(workorder.id) }
            end #end table 
        end #end panel 
    end #end show override
end

ActiveAdmin.register Worklog do
    belongs_to :workorder
    navigation_menu :workorder

    controller { with_role :admin } 

    controller do
        def create
            @workorder = Workorder.find(params[:workorder_id])
            @worklog = @workorder.worklogs.new(params[:worklog])
            
            if (@worklog.name.nil?)
                @worklog.name = current_admin_user.email
            end

            if (@worklog.state == "Deferred")
                @worklog.fac_man_only = true
            elsif (@worklog.state.nil?)
                @worklog.state = @worklog.workorder.state
            end

            if (@worklog.unsolicited.nil?)
                @worklog.unsolicited = false
            end

            if (@worklog.save)
                @workorder.state = @worklog.state #updates work order whenever worklog is created 
                @workorder.updated_at = @worklog.updated_at #update 'updated' time for workorder 
                
                if (@workorder.save)
                    flash[:success] = "Workorder updated!"
                    redirect_to admin_workorder_path(@workorder.id)
                end

            else
                flash[:error] = "Error occured, please try again"
                redirect_to admin_workorder_path(@workorder.id)
            end
        end #end create override

        def destroy
            @workorder = Workorder.find(params[:workorder_id])
            @worklog = @workorder.worklogs.find(params[:id])

            if @worklog.destroy
                flash[:error] = "Update has been deleted!"
            else
                flash[:error] = "An error has occurred, and the update may still exist. Please try again."
            end

            redirect_to admin_workorder_path(@workorder.id)

        end #end destroy override 

    end #end controller actions
  
end
